//
//  TextToAnimationView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI

struct TextToAnimationView: View {
    @State private var inputText: String = ""

    var body: some View {
        VStack {
            Text("Enter text to animate:")
                .font(.title2)
                .bold()

            TextField("Type something...", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Placeholder action for animation
                print("Animating: \(inputText)")
            }) {
                Text("Animate")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }

            Spacer()

            // Placeholder animation (replace with sign language animation later)
            Image(systemName: "waveform")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
                .opacity(inputText.isEmpty ? 0.3 : 1)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TextToAnimationView()
}
