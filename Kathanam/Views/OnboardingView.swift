//
//  OnboardingView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 08/03/25.
//
import SwiftUI

struct OnboardingView: View {
    @State private var showContentView = false

    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    // Feature 1: Home Screen
                    OnboardingScreenView(
                        title: "Learn Sign Language",
                        description: "Explore Indian, American Sign Language, and Autism courses with animations, quizzes, and quick videos.",
                        image: "house.fill"
                    )
                    
                    // Feature 2: Translator
                    OnboardingScreenView(
                        title: "Translator Features",
                        description: "Use Text-to-Animation, Sign-to-Text, and Text-to-Speech for seamless communication.",
                        image: "app.fill"
                    )
                    
                    // Feature 3: Shots
                    OnboardingScreenView(
                        title: "Quick Shots",
                        description: "Watch quick lessons like reels or YouTube shorts to learn sign language.",
                        image: "video.fill"
                    )
                    
                    // Feature 4: Dashboard
                    OnboardingScreenView(
                        title: "Your Dashboard",
                        description: "Track your learning progress, earn badges, and manage your user profile.",
                        image: "square.grid.2x2.fill"
                    )
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Allows swipe gestures between screens
                .edgesIgnoringSafeArea(.all)

                // After onboarding, transition to ContentView
                NavigationLink(
                    destination: ContentView(),
                    isActive: $showContentView,
                    label: {
                        Button(action: {
                            self.showContentView = true
                        }) {
                            Text("Get Started")
                                .font(.title2)
                                .bold()
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 30)
                    })
            }
            .navigationBarBackButtonHidden(true) // Hide the back button in navigation
        }
    }
}

struct OnboardingScreenView: View {
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        VStack {
            // SF Symbol Image
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150) // Adjust as needed
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 10)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
