import SwiftUI
import FirebaseAuth
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToHome = false
    @State private var errorMessage: String? = nil

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.orange, Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // Curved header background
                ZStack(alignment: .topLeading) {
                    WaveShape()
                        .fill(Color.orange)
                        .frame(height: 200)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome Back!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)

                        Text("Glad to see you, Again!")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 30)
                    .padding(.top, 50)
                }

                Spacer(minLength: 30)

                // Email Field
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.blue)
                    TextField("example@gmail.com", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)

                // Password Field with autofill management
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.blue)
                    SecureField("Password", text: $password)
                        .textContentType(.password) // Ensures the system treats this as a password field
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                       
                    Button(action: {
                        print("Toggle password visibility")
                    }) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)

                // Forgot Password
                HStack {
                    Spacer()
                    Button(action: {
                        print("Forgot Password tapped")
                    }) {
                        Text("Forgot Password?")
                            .font(.system(size: 16))
                            .foregroundColor(.purple)
                            .padding(.trailing, 30)
                    }
                }

                Spacer(minLength: 20)

                // Log In Button
                Button(action: loginUser) {
                    Text("Log In")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .shadow(radius: 5)
                }

                // Social Login
                HStack {
                    Text("or Login with")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.vertical, 20)
                }

                HStack(spacing: 30) {
                    // Facebook Icon
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("f")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                        )

                    // Google Icon
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Text("G")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.red)
                        )
                        .shadow(radius: 2)

                    // Apple Icon using SF Symbol
                    Circle()
                        .fill(Color.black)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "applelogo")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        )
                }
                .padding(.bottom, 20)

                // Register Now
                HStack {
                    Text("Don’t have an account?")
                        .font(.system(size: 16))
                    NavigationLink(destination: RegisterView()) {
                        Text("Register Now")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .background(
            NavigationLink(destination: MainTabView(), isActive: $navigateToHome) { EmptyView() }
        )
    }

    // Function to handle login logic
    func loginUser() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email or Password is empty."
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                print("Successfully logged in")
                // Save user details to UserDefaults for persistent session
                UserDefaults.standard.set(authResult?.user.uid, forKey: "userUID")
                UserDefaults.standard.set(self.email, forKey: "userEmail")

                // Optionally, save the user's name if it is stored in Firestore
                fetchUserDetails(uid: authResult?.user.uid)

                // Navigate to the home screen
                navigateToHome = true
            }
        }
    }

    // Fetch user details from Firestore (if you want to store name as well)
    func fetchUserDetails(uid: String?) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid ?? "")

        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let userData = document.data()
                let userName = userData?["name"] as? String ?? ""
                UserDefaults.standard.set(userName, forKey: "userName")
            }
        }
    }
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.height),
            control: CGPoint(x: rect.width / 2, y: rect.height - 100)
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.closeSubpath()
        return path
    }
}

#Preview {
    LoginView()
}

