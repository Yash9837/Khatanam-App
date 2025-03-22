import AVFoundation
import Vision

class CameraHandler: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private var videoOutput = AVCaptureVideoDataOutput()
    
    var onGestureRecognized: ((String) -> Void)?

    override init() {
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        session.sessionPreset = .high
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera) else { return }

        if session.canAddInput(input) { session.addInput(input) }
        if session.canAddOutput(videoOutput) { session.addOutput(videoOutput) }

        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
    }

    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
}

extension CameraHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNDetectHumanHandPoseRequest { request, error in
            guard let results = request.results as? [VNHumanHandPoseObservation], let hand = results.first else {
                return
            }
            
            self.processHandPose(hand)
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        try? handler.perform([request])
    }

    private func processHandPose(_ observation: VNHumanHandPoseObservation) {
        guard let thumbTip = try? observation.recognizedPoint(.thumbTip),
              let indexTip = try? observation.recognizedPoint(.indexTip),
              let middleTip = try? observation.recognizedPoint(.middleTip),
              let ringTip = try? observation.recognizedPoint(.ringTip),
              let pinkyTip = try? observation.recognizedPoint(.littleTip) else { return }
        
        let gesture = detectGestureLogic(thumbTip: thumbTip, indexTip: indexTip, middleTip: middleTip, ringTip: ringTip, pinkyTip: pinkyTip)
        
        DispatchQueue.main.async {
            self.onGestureRecognized?(gesture)
        }
    }
    
    private func detectGestureLogic(thumbTip: VNRecognizedPoint, indexTip: VNRecognizedPoint, middleTip: VNRecognizedPoint, ringTip: VNRecognizedPoint, pinkyTip: VNRecognizedPoint) -> String {
        // Distance function to calculate if tips are close to each other
        func distance(from p1: VNRecognizedPoint, to p2: VNRecognizedPoint) -> Float {
            return Float(sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2)))
        }

        // Gesture Dictionary: Store gestures and their labels
        let gestures: [String: String] = [
            "I Love You": "ASL Sign: I Love You 🤟",
            "A": "ASL Sign: A 👌",
            "Fist": "ASL Sign: Fist ✊",
            "Waving Hand": "Waving Hand 👋",
            "Open Hand": "Open Hand ✋",
            "Okay": "Okay 👍",
            "Hello": "Hello 👋",
            "Happy": "Happy 😀"
        ]
        
        // Gesture Detection Logic (based on finger tip positions)
        
        // ASL "I Love You" Gesture (Thumb and Little Finger Extended)
        if distance(from: indexTip, to: thumbTip) < 0.05 && distance(from: middleTip, to: indexTip) < 0.05 {
            return gestures["I Love You"] ?? "Unknown Gesture"
        }
        
        // ASL "A" Gesture (Fist with Thumb Extended)
        if distance(from: thumbTip, to: indexTip) > 0.15 && distance(from: indexTip, to: middleTip) < 0.05 {
            return gestures["A"] ?? "Unknown Gesture"
        }
        
        // ASL "Fist" Gesture (Fingers Closed)
        if distance(from: indexTip, to: pinkyTip) < 0.05 && distance(from: thumbTip, to: pinkyTip) < 0.05 {
            return gestures["Fist"] ?? "Unknown Gesture"
        }
        
        // "Waving Hand" Gesture (Waving motion with finger spread out)
        if indexTip.x < thumbTip.x && middleTip.x < thumbTip.x && ringTip.x < thumbTip.x && pinkyTip.x < thumbTip.x {
            return gestures["Waving Hand"] ?? "Unknown Gesture"
        }
        
        // "Open Hand" Gesture (Fingers spread out)
        if indexTip.y < thumbTip.y && middleTip.y < thumbTip.y && ringTip.y < thumbTip.y && pinkyTip.y < thumbTip.y {
            return gestures["Open Hand"] ?? "Unknown Gesture"
        }
        
        // "Okay" Gesture (Thumb and Index making a circle)
        if thumbTip.y > indexTip.y && thumbTip.y > middleTip.y && thumbTip.y > ringTip.y && thumbTip.y > pinkyTip.y {
            return gestures["Okay"] ?? "Unknown Gesture"
        }
        
        // "Hello" Gesture (Fingers Extended, resembling a greeting)
        if thumbTip.y < indexTip.y && indexTip.y < middleTip.y && middleTip.y < ringTip.y && ringTip.y < pinkyTip.y {
            return gestures["Hello"] ?? "Unknown Gesture"
        }

        // "Happy" Gesture (Fingers Spread Out in a Happy Gesture)
        if thumbTip.x < indexTip.x && indexTip.x < middleTip.x && middleTip.x < ringTip.x && ringTip.x < pinkyTip.x {
            return gestures["Happy"] ?? "Unknown Gesture"
        }
        
        return "Unknown Sign"
    }
}

