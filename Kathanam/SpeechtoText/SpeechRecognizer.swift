//
//  SpeechRecognizer.swift
//  Kathanam
//
//  Created by Yash's Mackbook on 07/03/25.
//
import Foundation
import Speech
import AVFoundation

class SpeechRecognizer: ObservableObject {
    @Published var transcribedText: String = ""
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let speechRecognizer: SFSpeechRecognizer?

    let supportedLanguages: [String] = ["en-US", "hi-IN"] // ✅ Apple only supports these

    init(languageCode: String) {
        if supportedLanguages.contains(languageCode) {
            self.speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: languageCode))
        } else {
            self.speechRecognizer = nil
        }
    }

    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus != .authorized {
                    self.transcribedText = "Speech recognition permission denied."
                }
            }
        }
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            if !granted {
                DispatchQueue.main.async {
                    self.transcribedText = "Microphone permission denied."
                }
            }
        }
    }

    func startTranscribing() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            transcribedText = "❌ Speech recognition not available for this language."
            return
        }

        do {
            recognitionTask?.cancel()
            recognitionTask = nil
            
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            let inputNode = audioEngine.inputNode
            let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            recognitionRequest.shouldReportPartialResults = true
            self.recognitionRequest = recognitionRequest

            recognitionTask = recognizer.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    DispatchQueue.main.async {
                        self.transcribedText = result.bestTranscription.formattedString
                    }
                }
                
                if error != nil || (result?.isFinal ?? false) {
                    self.stopTranscribing()
                }
            }

            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
                recognitionRequest.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            transcribedText = "Error starting speech recognition: \(error.localizedDescription)"
        }
    }

    func stopTranscribing() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask = nil
    }
}


class AudioRecorder: NSObject, AVAudioRecorderDelegate {
    private var audioRecorder: AVAudioRecorder?
    private let audioFilename = FileManager.default.temporaryDirectory.appendingPathComponent("speech.wav")

    func startRecording(completion: @escaping (URL?) -> Void) {
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,  // Google needs LINEAR16 format
            AVSampleRateKey: 16000.0,              // Google requires 16,000 Hz sample rate
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            print("🎙 Recording started: \(audioFilename)")
            completion(audioFilename) // Call the completion block when the recording starts
        } catch {
            print("❌ Recording failed: \(error)")
            completion(nil)
        }
    }

    func stopRecording(completion: @escaping (URL?) -> Void) {
        audioRecorder?.stop()
        completion(audioFilename) // Call completion with the file URL after stopping
    }
}



class GoogleSpeechAPI {
    let accessToken = "ya29.a0AeXRPp7Rl5lgttuL-0C5Z22l4adiQKJok1yIYasE9OogQpReTMV_-o5pwtOM6ZmTklHT_o_68wx_U9SaJRHHZ6QzqSm-KYDAI-hMtwttvdr5KqltjSPeO_vHITnKOl6L3rPD7BR1Q2ZDuQl41AWmXqMez5-uY6AHr0nSK2UgaCgYKAU8SARESFQHGX2MizVLRju6KdCvbZ-UhVz-cbA0175" //

        func transcribeAudio(base64Audio: String, languageCode: String, completion: @escaping (String?) -> Void) {
            let requestBody: [String: Any] = [
                "config": [
                    "encoding": "LINEAR16",
                    "sampleRateHertz": 16000,
                    "languageCode": languageCode
                ],
                "audio": [
                    "content": base64Audio // ✅ Send as Base64 string
                ]
            ]

            guard let url = URL(string: "https://speech.googleapis.com/v1/speech:recognize") else {
                completion(nil)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }

                if let responseJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = responseJson["results"] as? [[String: Any]],
                   let firstResult = results.first,
                   let alternatives = firstResult["alternatives"] as? [[String: Any]],
                   let transcript = alternatives.first?["transcript"] as? String {
                    completion(transcript)
                } else {
                    completion("❌ No speech detected.")
                }
            }.resume()
        }
    }
