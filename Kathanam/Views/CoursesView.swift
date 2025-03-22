//
//  CoursesView.swift
//  Kathanam
//
//  Created by palak seth on 16/02/25.
//
import SwiftUI
import WebKit

// MARK: - Video Model
struct Video: Identifiable {
    let id = UUID()
    let title: String
    let url: String
}

// MARK: - Level Model
struct Level: Identifiable {
    let id = UUID()
    let title: String
    let videos: [Video]
}

// MARK: - Course Model
struct Course: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let levels: [Level]
}

// MARK: - CoursesView
struct CoursesView: View {
    let courses: [Course] = [
        Course(
            title: "Indian Sign Language",
            imageName: "isl_image",
            levels: [
                Level(title: "Beginner", videos: [
                    Video(title: "ISL Beginner 1", url: "https://youtu.be/Vj_13bdU4dU?si=vR2Gx9RVyHgBwaWc"),
                    Video(title: "ISL Beginner 2", url: "https://youtu.be/vnH2BmcSRMA?si=Fav3e69xjFuEpp8u"),
                    Video(title: "ISL Beginner 3", url: "https://youtu.be/qtrBGmioR2Q?si=f2gy_sHw5WYjppTj")
                ]),
                Level(title: "Intermediate", videos: [
                    Video(title: "ISL Intermediate 1", url: "https://youtu.be/VtbYvVDItvg?si=qr2vagvSzCOqbLS9"),
                    Video(title: "ISL Intermediate 2", url: "https://youtu.be/lffGJ29IhZQ?si=N4UYRq5c8sxZrqXR"),
                    Video(title: "ISL Intermediate 3", url: "https://youtu.be/vGRP1nFPS80?si=m69nAops577QGMD1")
                ]),
                Level(title: "Advanced", videos: [
                    Video(title: "ISL Advanced 1", url: "https://youtu.be/DOFPRw6Epl0?si=YOYYcfhGXknUKOPU"),
                    Video(title: "ISL Advanced 2", url: "https://youtu.be/XiyJFuz01PE?si=uPZizKDpAgNSDz_9"),
                    Video(title: "ISL Advanced 3", url: "https://youtu.be/8sLVNe576BM?si=Rjmr6E3hT8lbzsnY")
                ])
            ]
        ),
        Course(
            title: "American Sign Language",
            imageName: "asl_image",
            levels: [
                Level(title: "Beginner", videos: [
                    Video(title: "ASL Beginner 1", url: "https://youtu.be/DBQINq0SsAw?si=t1I8uuH8C6cJKsLT"),
                    Video(title: "ASL Beginner 2", url: "https://youtu.be/0FcwzMq4iWg?si=bJZbhhYFjWmKkgJ2"),
                    Video(title: "ASL Beginner 3", url: "https://youtu.be/6w1ZDaE-whc?si=foaOAuecs3wY3MvS")
                ]),
                Level(title: "Intermediate", videos: [
                    Video(title: "ASL Intermediate 1", url: "https://youtu.be/U9KnRdcWL7Y?si=XNTXD-Co_OS03srs"),
                    Video(title: "ASL Intermediate 2", url: "https://youtu.be/uKtIdUxUqcA?si=ywyH70y0O3_qK7KS"),
                    Video(title: "ASL Intermediate 3", url: "https://youtu.be/qm2-kiYSzSs?si=9phgEwVvJm3MLJk5")
                ]),
                Level(title: "Advanced", videos: [
                    Video(title: "ASL Advanced 1", url: "https://youtu.be/VOnHnaNiVSM?si=6CAnxGO9ia9oIO5A"),
                    Video(title: "ASL Advanced 2", url: "https://youtu.be/i4cMA5yzDlw?si=1K7BO6N5eY2k9u0v"),
                    Video(title: "ASL Advanced 3", url: "https://youtu.be/K2RUbjE6jA8?si=nOkNb3IQ6nmjcWVB")
                ])
            ]
        ),
        Course(
            title: "Autism Communication",
            imageName: "autism_image",
            levels: [
                Level(title: "Beginner", videos: [
                    Video(title: "Autism Beginner 1", url: "https://youtu.be/8xpjvvS4048?si=VsmkteCI_GeCcdyz"),
                    Video(title: "Autism Beginner 2", url: "https://youtu.be/2krqjvHQSCY?si=TzwnB670qSLS1nVL"),
                    Video(title: "Autism Beginner 3", url: "https://youtu.be/cOLFgnLp0E4?si=NgP-2DkepUNTpesY")
                ]),
                Level(title: "Intermediate", videos: [
                    Video(title: "Autism Intermediate 1", url: "https://youtu.be/Dl79ZADT0Zg?si=IEOsfyjtyNMZcVZU"),
                    Video(title: "Autism Intermediate 2", url: "https://youtu.be/dt3jm6_-UoA?si=5nqUk72_BHcbxpSM"),
                    Video(title: "Autism Intermediate 3", url: "https://youtu.be/L9ij9b9JAiw?si=3HlFQmJOPwfGM_Yv")
                ]),
                Level(title: "Advanced", videos: [
                    Video(title: "Autism Advanced 1", url: "https://youtu.be/qtf8DOUq8uk?si=7wl5Wsw4E0-gr01D"),
                    Video(title: "Autism Advanced 2", url: "https://youtu.be/qtf8DOUq8uk?si=brJOeFiXvW0TuFJx"),
                    Video(title: "Autism Advanced 3", url: "https://youtu.be/EBHwZjsR-Fc?si=EdiMYi7sqwVarjIp")
                ])
            ]
        )
    ]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    Text("Courses")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 50)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(courses) { course in
                                NavigationLink(destination: LevelsView(levels: course.levels, courseTitle: course.title)) {
                                    HStack(spacing:20) {
                                        Image(course.imageName)
                                            .resizable()
                                            
                                            .frame(width: 180, height: 120)
                                            .cornerRadius(10)
                                        
                                        
                                        Text(course.title)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.9))
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

// MARK: - LevelsView
struct LevelsView: View {
    let levels: [Level]
    let courseTitle: String
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text(courseTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(levels) { level in
                            NavigationLink(destination: VideosView(videos: level.videos, levelTitle: level.title)) {
                                Text(level.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.3))
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// MARK: - VideosView
struct VideosView: View {
    let videos: [Video]
    let levelTitle: String
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text(levelTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(videos) { video in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(video.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                WebView(url: video.url)
                                    .frame(height: 200)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}


// MARK: - WebView (For YouTube Previews)
struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
}

#Preview {
    CoursesView()
}
