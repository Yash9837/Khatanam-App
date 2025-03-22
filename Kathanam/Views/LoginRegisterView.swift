//
//  LoginRegisterView.swift
//  Kathanam
//
//  Created by palak seth on 09/02/25.
//

import SwiftUI

struct LoginRegisterView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient for the page
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Circle with the custom logo inside
                    ZStack {
                        Circle() // White circle behind the logo
                            .fill(Color.white)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)

                        // Custom logo
                        Image("logo") // Use the image added to Assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150) // Increased logo size
                            .clipShape(Circle()) // Optional circular clipping
                    }
                    .padding(.top, 40)

                    // Title "KATHANAM"
                    Text("KATHANAM")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.blue)

                    // Subtitle in another language
                    Text("కథనం")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.blue)

                    // Tagline
                    Text("Where Every Sign\nTells a Story.")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.top, 10)

                    Spacer()

                    // Register Button
                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 10)

                    // Log In Button
                    NavigationLink(destination: LoginView()) {
                        Text("Log In")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 50)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginRegisterView()
}
