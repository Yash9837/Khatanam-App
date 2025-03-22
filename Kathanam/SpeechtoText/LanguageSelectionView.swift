//
//  LanguageSelectionView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 07/03/25.
//
import SwiftUI

struct LanguageSelectionView: View {
    let languages = [
        ("English", "en-US"),
        ("हिन्दी (Hindi)", "hi-IN"),
        ("ગુજરાતી (Gujarati)", "gu-IN"),
        ("తెలుగు (Telugu)", "te-IN")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Enhanced Background Gradient (Orange to Yellow with a slight fade)
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Title Section with Shadow and Padding
                    Text("Select a Language")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .shadow(radius: 10)
                    
                    // Language Selection Buttons with more interactivity
                    ForEach(languages, id: \.0) { language in
                        NavigationLink(destination: SpeechToTextView(languageCode: language.1)) {
                            Text(language.0)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    Capsule()
                                        .fill(Color.white.opacity(0.8))
                                        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 6)
                                )
                                .foregroundColor(.black)
                                .overlay(
                                    Capsule()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )
                                .scaleEffect(1.05)
                                .animation(.easeInOut(duration: 0.2), value: 0)
                        }
                        .padding(.horizontal, 40)
                    }
                }
                .padding(.top, -50)
                .padding(.horizontal, 30)
            }
            .navigationTitle("") // No title at the top
            .navigationBarHidden(true) // Hide the default navigation bar for custom UI
        }
    }
}



struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView()
    }
}
