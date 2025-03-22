import SwiftUI
import FirebaseAuth
import FirebaseFirestore

// Define the data models
struct RecentLearning: Identifiable {
    let id = UUID()
    let subject: String
    let title: String
    let progress: String
    let imageName: String
}

struct RecommendedCourse: Identifiable {
    let id = UUID()
    let subject: String
    let title: String
    let lessons: String
    let imageName: String
}

struct QuickVideo: Identifiable {
    let id = UUID()
    let title: String
    let videoID: String
}

struct QuickVideo2: Identifiable {
    let id = UUID()
    let title: String
}

struct ReviseContent: Identifiable {
    let id = UUID()
    let title: String
}

struct Quiz: Identifiable {
    let id = UUID()
    let title: String
}

struct HomeView: View {
    @State private var username: String = "John Doe"  // Default name if user is not logged in
    @State private var userUID: String = ""  // Store the logged-in user's UID
    
    // Firestore reference
    let db = Firestore.firestore()

    // Example data for sections
    let recentLearnings: [RecentLearning] = [
        RecentLearning(subject: "ASL", title: "Sign Basics", progress: "5/10", imageName: "asl_image"),
        RecentLearning(subject: "ISL", title: "Cultural Expressions", progress: "7/10", imageName: "isl_image"),
        RecentLearning(subject: "Autistic", title: "Social Interaction", progress: "8/10", imageName: "autism_image")
    ]
    
    let recommendedCourses: [RecommendedCourse] = [
        RecommendedCourse(subject: "ISL", title: "Cultural Expressions", lessons: "7", imageName: "isl_image"),
        RecommendedCourse(subject: "ASL", title: "Sign Basics", lessons: "5", imageName: "asl_image"),
        RecommendedCourse(subject: "Autistic", title: "Social Interaction", lessons: "8", imageName: "autism_image")
    ]
    
    let quickVideos: [QuickVideo] = [
        QuickVideo(title: "25 ASL Signs You Need", videoID: "0FcwzMq4iWg"),
        QuickVideo(title: "20+ Basic Sign", videoID: "v1desDduz5M"),
        QuickVideo(title: "100 Essential ASL Signs", videoID: "stCwx6SXgSA"),
        QuickVideo(title: "Greetings in ASL", videoID: "uKKvNqA9N20")
    ]
    
    let reviseContent: [ReviseContent] = [
        ReviseContent(title: "Ace Your Tests"),
        ReviseContent(title: "Important Topics"),
        ReviseContent(title: "Revise in 10 Minutes")
    ]
    
    let quizzes: [Quiz] = [
        Quiz(title: "Play Quiz Challenge"),
        Quiz(title: "Practice Tests"),
        Quiz(title: "Interactive Quizzes")
    ]
    
    // Fetch the user's name when the view appears
    func fetchUserName() {
        if let userUID = UserDefaults.standard.string(forKey: "userUID") {
            // User is logged in, fetch user details from Firestore
            db.collection("users").document(userUID).getDocument { (document, error) in
                if let document = document, document.exists {
                    let userData = document.data()
                    self.username = userData?["name"] as? String ?? "John Doe" // Default to "John Doe" if no name
                } else {
                    print("User not found in Firestore.")
                }
            }
        } else {
            print("No user logged in.")
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    headerView()
                    
                    // Scrollable content
                    ScrollView {
                        VStack(spacing: 20) {
                            // Greeting and search bar
                            greetingView()
                            
                            // Recent Learning Section
                            VStack(alignment: .leading, spacing: 10) {
                                sectionTitle("Recent Learning")

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: -50) {
                                        ForEach(recentLearnings) { learning in
                                            GeometryReader { proxy in
                                                let scale = calculateScale(proxy: proxy)
                                                
                                                recentLearningCard(
                                                    subject: learning.subject,
                                                    title: learning.title,
                                                    progress: learning.progress,
                                                    imageName: learning.imageName
                                                )
                                                .scaleEffect(scale)
                                                .animation(.spring(), value: scale)
                                            }
                                            .frame(width: 320, height: 250)
                                        }
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, -40)
                                }
                            }

                            // Quick Videos Section
                            sectionWithHorizontalScroll(
                                title: "Quick Videos",
                                items: quickVideos
                            ) { video in
                                quickVideoCard(video: video)
                            }

                            // Recommended Courses
                            sectionWithHorizontalScroll(
                                title: "Recommended",
                                items: recommendedCourses
                            ) { course in
                                courseCard(subject: course.subject, title: course.title, lessons: course.lessons, imageName: course.imageName)
                            }.padding(.bottom, 20)
                            
                            // Revise Section
                            sectionWithVerticalCards(
                                title: "Revise",
                                items: reviseContent
                            ) { content in
                                reviseCard(title: content.title)
                            }
                            
                            // Quizzes Section
                            VStack(alignment: .leading, spacing: 10) {
                                sectionTitle("Quizzes")
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 15) {
                                        ForEach(quizzes) { quiz in
                                            quizCard(title: quiz.title)
                                                .frame(width: 300)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                    
                }
            }
            .onAppear {
                fetchUserName() // Fetch the user's name when the view appears
            }
            .navigationBarBackButtonHidden(true)
        }
        .navigationBarHidden(true)
    }
    
    // Header View
    func headerView() -> some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            Spacer()
            
            VStack {
                Image(systemName: "bell.fill")
                    .foregroundColor(.white)
                Text("Notifications")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.orange)
    }
    // Course Card
       func courseCard(subject: String, title: String, lessons: String, imageName: String) -> some View {
           VStack(alignment: .leading, spacing: 10) {
               Image(imageName)
                   .resizable()
                   .scaledToFill()
                   .frame(height: 100)
                   .cornerRadius(10)
                   .shadow(radius: 3)

               Text(subject)
                   .font(.system(size: 14, weight: .bold))
                   .foregroundColor(.gray)

               Text(title)
                   .font(.system(size: 16, weight: .bold))
                   .foregroundColor(.black)

               HStack {
                   Text(lessons)
                   Text("Lessons")
               }
           }
           .padding()
           .background(Color.white)
           .cornerRadius(15)
           .shadow(radius: 5)
           .frame(width: 250)
       }
    // Greeting View
    func greetingView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hi, \(username)") // Display the fetched username
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("What do you want to learn today?")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: .constant(""))
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
        .padding(.horizontal)
    }

    // Section Title
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.black)
            .padding(.horizontal)
    }
    func openYouTube(videoID: String) {
           let youtubeURL = URL(string: "youtube://\(videoID)")!
           let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)")!

           if UIApplication.shared.canOpenURL(youtubeURL) {
               UIApplication.shared.open(youtubeURL)
           } else {
               UIApplication.shared.open(webURL)
           }
       }
    func quickVideoCard(video: QuickVideo) -> some View {
           Button(action: {
               openYouTube(videoID: video.videoID)
           }) {
               VStack {
                   AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(video.videoID)/hqdefault.jpg")) { image in
                       image.resizable()
                           .scaledToFill()
                           .frame(width: 200, height: 120)
                           .cornerRadius(10)
                   } placeholder: {
                       ProgressView()
                           .frame(width: 200, height: 120)
                   }

                   Text(video.title)
                       .font(.system(size: 14, weight: .bold))
                       .foregroundColor(.black)
                       .padding(.top, 5)
               }
               .frame(width: 200, height: 160)
               .background(Color.white)
               .cornerRadius(10)
               .shadow(radius: 2)
           }
       }
    // Section With Horizontal Scroll
    func sectionWithHorizontalScroll<Item: Identifiable, Content: View>(
        title: String,
        items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items) { item in
                        content(item)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    // Section With Vertical Cards
    func sectionWithVerticalCards<Item: Identifiable, Content: View>(
        title: String,
        items: [Item],
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(title)
            
            VStack(spacing: 15) {
                ForEach(items) { item in
                    content(item)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // Recent Learning Card
    func recentLearningCard(subject: String, title: String, progress: String, imageName: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                .cornerRadius(10)
                .shadow(radius: 3)

            Text(subject)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.gray)

            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)

            HStack {
                ProgressView(value: Float(progress.split(separator: "/").first!) ?? 0, total: 10)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(height: 8)

                Text(progress)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .frame(width: 250)
    }

    // Calculate scale for 3D effect on cards
    func calculateScale(proxy: GeometryProxy) -> CGFloat {
        let midX = proxy.frame(in: .global).midX
        let screenMidX = UIScreen.main.bounds.width / 2
        let distance = abs(screenMidX - midX)
        
        // Adjust scaling based on the distance from the center
        let scale = max(1 - (distance / 400), 0.9) // Minimum scale is 0.9
        return scale
    }

    // Revise Card
    func reviseCard(title: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "note.text")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Revise with Chapter Summary & Important Questions in under 10 minutes.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Button(action: {
                // Handle the button action here
                print("Start Revision tapped!")
            }) {
                Text("Start Revision")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
    
    // Quiz Card
    func quizCard(title: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "timer")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.pink)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Go head to head with students worldwide.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Button(action: {
                // Handle the button action here
                print("Play Now tapped!")
            }) {
                Text("Play Now")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.pink.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 1)
        .padding(.bottom, 80)
    }
}

#Preview{
    HomeView()
}
