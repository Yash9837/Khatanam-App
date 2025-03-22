import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showSuccessPopup = false
    @State private var navigateToHome = false
    @State private var errorMessage: String? = nil

    // Firestore reference
    let db = Firestore.firestore()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    ZStack(alignment: .topLeading) {
                        WaveShape()
                            .fill(Color.orange)
                            .frame(height: 200)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Hello! Register to")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)

                            Text("get started")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 30)
                        .padding(.top, 50)
                    }

                    Spacer(minLength: 20)

                    // Name Field
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        TextField("Name", text: $name)  // Changed from 'Username' to 'Name'
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)

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

                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        SecureField("Password", text: $password)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)

                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        SecureField("Confirm Password", text: $confirmPassword)
                            .textContentType(.newPassword)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)

                    // Show error message if registration fails
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Spacer(minLength: 20)

                    Button(action: registerUser) {
                        Text("Register")
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            .shadow(radius: 5)
                    }
                    .alert("You have successfully been registered!", isPresented: $showSuccessPopup) {
                        Button("OK", action: {
                            navigateToHome = true
                        })
                    }

                    NavigationLink(destination: MainTabView(), isActive: $navigateToHome) {
                        EmptyView()
                    }

                    HStack {
                        Text("or Register with")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .padding(.vertical, 20)
                    }

                    HStack(spacing: 30) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("f")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.white)
                            )

                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("G")
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(.red)
                            )
                            .shadow(radius: 2)

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

                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 16))
                        NavigationLink(destination: LoginView()) {
                            Text("Login Now")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }

    // Function to handle registration logic and saving name in Firestore
    func registerUser() {
        guard !name.isEmpty else {
            errorMessage = "Name cannot be empty."
            return
        }
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            return
        }

        // Create a user with Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                // Save user data in Firestore
                let userRef = self.db.collection("users").document(authResult!.user.uid)
                userRef.setData([
                    "name": self.name,
                    "email": self.email
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("User data saved successfully!")
                    }
                }

                // Save the user details in UserDefaults to keep the session persistent
                UserDefaults.standard.set(authResult?.user.uid, forKey: "userUID")
                UserDefaults.standard.set(self.name, forKey: "userName")
                UserDefaults.standard.set(self.email, forKey: "userEmail")

                showSuccessPopup = true
            }
        }
    }
}

#Preview {
    RegisterView()
}

