//
//  SpeechToTextView.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 07/03/25.
//

import SwiftUI

struct SpeechToTextView: View {
    @State private var transcribedText: String = ""
    @State private var savedFilePath: String = ""
    @State private var completedFilePath: String = ""
    @State private var isRecording: Bool = false
    @State private var isTranscribing: Bool = false
    @State private var previousMessages: [String] = [] // To store previous transcriptions
    
    @StateObject private var speechRecognizer: SpeechRecognizer
    private let speechAPI = GoogleSpeechAPI()
    private let languageCode: String
    private let useGoogleAPI: Bool

    init(languageCode: String) {
        self.languageCode = languageCode
        _speechRecognizer = StateObject(wrappedValue: SpeechRecognizer(languageCode: languageCode))
        self.useGoogleAPI = (languageCode == "gu-IN" || languageCode == "te-IN") // Use Google API for Gujarati & Telugu
    }

    var body: some View {
        NavigationView {
            VStack {
                // Title Section with Back Button
                HStack {
//                    // Back Button
//                    Button(action: {
//                        // Action for back button
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .font(.title)
//                            .foregroundColor(.white)
//                    }
//                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("Speech-to-Text (\(getLanguageName(languageCode)))")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    Spacer()
                }
                
                Spacer()
                
                // Microphone and Text Display
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.15))
                        .shadow(radius: 10)
                    
                    VStack {
                        Text("Listening...")
                            .font(.title2)
                            .foregroundColor(.white)
                            .opacity(isRecording ? 1 : 0)
                        
                        ScrollView {
                            Text(transcribedText)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(height: 200)
                        
                        // Show previous transcriptions
                        if !previousMessages.isEmpty {
                            Text("Previous Messages")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                            
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(previousMessages, id: \.self) { message in
                                        Text(message)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.white.opacity(0.1))
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .frame(height: 150)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Controls
                HStack(spacing: 30) {
                    // Start Recording Button with microphone icon
                    Button(action: {
                        startRecording()
                    }) {
                        HStack {
                            Image(systemName: "mic.fill")
                                .font(.title)
                            Text("Start")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .frame(width: 150, height: 60) // Consistent size for button
                        .background(isRecording ? Color.green : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                    }
                    .disabled(isRecording) // Disable while recording

                    // Stop Recording Button
                    Button(action: {
                        stopRecording()
                    }) {
                        HStack {
                            Image(systemName: "stop.fill")
                                .font(.title)
                            Text("Stop")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .frame(width: 150, height: 60) // Consistent size for button
                        .background(isRecording ? Color.red : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                    }
                    .disabled(!isRecording) // Disable if not recording
                }
                .padding(.top, 30)
                
                // Show saved and completed file paths
                VStack(spacing: 10) {
                    Text("Saved File Path: \(savedFilePath)")
                        .font(.footnote)
                        .foregroundColor(.gray)

                    if !completedFilePath.isEmpty {
                        Text("Completed File Path: \(completedFilePath)")
                            .font(.footnote)
                            .foregroundColor(.green)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.white]),
                                       startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea())
            .navigationBarBackButtonHidden(true) // Hide default back button
        }
    }

    func startRecording() {
        isRecording = true
        if useGoogleAPI {
            AudioRecorder().startRecording { audioURL in
                guard let audioURL = audioURL else { return }
                savedFilePath = audioURL.path
                print("🎙 Recording started: \(audioURL.path)")
            }
        } else {
            speechRecognizer.startTranscribing()
        }
    }

    func stopRecording() {
        isRecording = false
        if useGoogleAPI {
            AudioRecorder().stopRecording { audioURL in
                guard let audioURL = audioURL else { return }
                do {
                    let audioData = try Data(contentsOf: audioURL)
                    completedFilePath = audioURL.path
                    speechAPI.transcribeAudio(base64Audio: audioData.base64EncodedString(), languageCode: languageCode) { result in
                        DispatchQueue.main.async {
                            transcribedText = result ?? "No speech detected."
                            previousMessages.insert(transcribedText, at: 0) // Store previous message
                        }
                    }
                } catch {
                    print("❌ Failed to load audio data: \(error)")
                }
            }
        } else {
            speechRecognizer.stopTranscribing()
            transcribedText = speechRecognizer.transcribedText
            previousMessages.insert(transcribedText, at: 0) // Store previous message
        }
        isTranscribing = true
    }

    func getLanguageName(_ code: String) -> String {
        switch code {
        case "en-US": return "English"
        case "hi-IN": return "Hindi"
        case "gu-IN": return "Gujarati"
        case "te-IN": return "Telugu"
        default: return "Unknown"
        }
    }
}
