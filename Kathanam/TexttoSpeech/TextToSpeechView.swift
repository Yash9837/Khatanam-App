//
//  TextToSpeechView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI
import AVFoundation

struct TextToSpeechView: View {
    @State private var textToRead: String = ""
    @State private var synthesizer = AVSpeechSynthesizer()
    var languageCode: String
    var languageName: String
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Text to enter
                TextField("Enter text here", text: $textToRead)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.horizontal, 30)
                
                // Speak Button
                Button(action: {
                    speakText(text: textToRead)
                }) {
                    Text("Speak")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .navigationTitle("\(languageName) Text-to-Speech")
    }
    
    func speakText(text: String) {
        if text.isEmpty {
            return
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
