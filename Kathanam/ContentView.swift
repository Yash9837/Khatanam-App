import SwiftUI

struct ContentView: View {
    @State private var showLoginRegisterView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 5) {
                    // Circle with the custom logo inside
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 150, height: 150) // Adjusted circle size
                            .shadow(radius: 10)

                        // Custom logo
                        Image("logo") // Use the image added to Assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120) // Adjusted logo size
                            .clipShape(Circle()) // Optional circular clipping
                    }
                    .padding(.top, 5) // Adjusted top padding

                    // Title "KATHANAM"
                    Text("KATHANAM")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.top, 10)

                    // Subtitle in another language
                    Text("కథనం")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.blue)

                    // Tagline
                    Text("Where Every Sign Tells a Story.")
                        .font(.system(size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.top, 10)

                    // Feature List (Onboarding)
                    VStack(spacing: 15) {
                        FeatureRow(
                            icon: "house.fill",
                            title: "Learn Sign Language",
                            description: "Explore Indian, American Sign Language, and Autism courses with animations, quizzes, and quick videos."
                        )
                        
                        FeatureRow(
                            icon: "textformat.size",
                            title: "Translator Features",
                            description: "Use Text-to-Animation, Sign-to-Text, and Text-to-Speech for seamless communication."
                        )
                        
                        FeatureRow(
                            icon: "play.rectangle.fill",
                            title: "Quick Shots",
                            description: "Watch quick lessons like reels or YouTube shorts to learn sign language."
                        )
                        
                        FeatureRow(
                            icon: "person.fill",
                            title: "Your Dashboard",
                            description: "Track your learning progress, earn badges, and manage your user profile."
                        )
                    }
                    .padding(.horizontal, 15)
                    
                    // Spacer to push the "Get Started" button down
                    Spacer()

                    // Get Started Button
                    NavigationLink(destination: LoginRegisterView(), isActive: $showLoginRegisterView) {
                        Button(action: {
                            self.showLoginRegisterView = true
                        }) {
                            Text("GET STARTED")
                                .font(.system(size: 20, weight: .bold))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.bottom, 30) // Space at the bottom
                }
                .padding(.horizontal, 20) // Horizontal padding to avoid clipping
            }
        }
    }
}

// Feature Row for each feature description
struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            // Icon
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 60, height: 60)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
            
            // Text Content
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            .padding(.leading, 10)
        }
        .padding(.vertical, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

