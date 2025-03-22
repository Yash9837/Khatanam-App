//
//  LanguageSelectionView2.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 08/03/25.
//
import SwiftUI

struct LanguageSelectionView2: View {
    let languages = [
        ("English", "en-US"),
        ("हिन्दी (Hindi)", "hi-IN"),
        ("ગુજરાતી (Gujarati)", "gu-IN"),
        ("తెలుగు (Telugu)", "te-IN")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Title Section with Shadow and Padding
                    Text("Select a Language")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .shadow(radius: 10)
                    
                    
                    ForEach(languages, id: \.0) { language in
                        NavigationLink(destination: TextToSpeechView(languageCode: language.1, languageName: language.0)) {
                            Text(language.0)
                                .font(.title2)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(1))
                                .cornerRadius(40)
                                .foregroundColor(.black)
                                .shadow(radius: 5)
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)
                    }
                }
                .padding(.top, -80)
                .padding(.horizontal, 30)
            }
        }
    }
}
#Preview {
    LanguageSelectionView2()
}
