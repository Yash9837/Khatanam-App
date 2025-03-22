//
//  TranslateView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//
import SwiftUI

struct TranslateView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // ✅ Background Similar to Your App
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {
                    // ✅ Title Section
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Let's translate")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.black)

                        Text("anything with ease")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                    // ✅ Translation Feature Cards
                    VStack(spacing: 15) {
                        translationOption(
                            title: "Translate AI",
                            subtitle: "Let’s use AI easily",
                            icon: "character.book.closed.fill",
                            bgColor: Color.orange.opacity(0.8),
                            destination: LanguageSelectionView2())
                        translationOption(
                            title: "Camera",
                            subtitle: "Scan and translate",
                            icon: "camera.fill",
                            bgColor: Color.blue.opacity(0.8),
                            destination: SignToTextView()
                        )
                        translationOption(
                            title: "Voice",
                            subtitle: "Speak and you’ll understand",
                            icon: "mic.fill",
                            bgColor: Color.green.opacity(0.8),
                            destination: LanguageSelectionView()
                        )

                        
                        
                    }

                    Spacer()
                }
                .padding(.top, 50)
            }
        }
    }

    // ✅ Custom Button Design for Each Translation Mode
    func translationOption<Destination: View>(
        title: String,
        subtitle: String,
        icon: String,
        bgColor: Color,
        destination: Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                // ✅ Icon with Rounded Background
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(bgColor)
                        .frame(width: 60, height: 60)

                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(.black)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)

                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(bgColor.opacity(0.4))
            .cornerRadius(20)
            .padding(.horizontal)
            .shadow(radius: 3)
        }
    }
}

#Preview {
    TranslateView()
}
