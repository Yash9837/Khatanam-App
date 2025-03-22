//
//  SignToTextView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 26/02/25.
//

import SwiftUI
import AVFoundation
import Vision

struct SignToTextView: View {
    @State private var recognizedGesture: String = "Show a sign"
    private let cameraHandler = CameraHandler()

    var body: some View {
        ZStack {
            CameraPreview(session: cameraHandler.session)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text(recognizedGesture)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding()
            }
        }
        .onAppear {
            cameraHandler.startSession()
            cameraHandler.onGestureRecognized = { gesture in
                recognizedGesture = gesture
            }
        }
    }
}

#Preview {
    SignToTextView()
}
    
