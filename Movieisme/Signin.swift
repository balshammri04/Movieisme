import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showError: Bool = false
    @State private var isButtonActive: Bool = false
    @FocusState private var focusedField: Field?

    enum Field {
        case email, password
    }

    var body: some View {
        ZStack {
            // Background image
            Image("signin") // Replace with your background asset name
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            // Gradient overlay
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.3)]),
                           startPoint: .bottom,
                           endPoint: .top)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()
                
                // Title and subtitle
                VStack(alignment: .leading, spacing: 8) {
                    Text("Sign in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("You'll find what you're looking for in the ocean of movies")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)


                // Input fields
                VStack(spacing: 15) {
                    // Email label and field
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Email")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            //.padding(.horizontal)

                        TextField("", text: $email)
                            .placeholder(when: email.isEmpty) {
                                Text("Enter your email")
                                 .foregroundColor(.white.opacity(0.70)) // Placeholder color
                            }
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color.white.opacity(0.50))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(focusedField == .email ? Color.yellow : Color.clear, lineWidth: 2)
                            )
                            .focused($focusedField, equals: .email)
                    }

                    // Password label and field
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Password")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)

                        HStack {
                            if isPasswordVisible {
                                TextField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password")
                                            .foregroundColor(.white.opacity(0.70)) // Placeholder color
                                    }
                            } else {
                                SecureField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password")
                                            .foregroundColor(.white.opacity(0.70))// Placeholder color
                                    }
                            }

                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.50))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focusedField == .password ? Color.yellow : Color.clear, lineWidth: 2)
                        )
                        .focused($focusedField, equals: .password)
                    }

                    // Error message
                    if showError {
                        Text("Invalid password")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.padding(.horizontal)
                    }
                }

                // Sign-in button
                Button(action: {
                    if email.isEmpty || password.isEmpty || password != "password123" { // Replace with your validation logic
                        showError = true
                    } else {
                        showError = false
                        // Proceed with login
                    }
                }) {
                    Text("Sign in")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isButtonActive ? Color.yellow : Color.gray)
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
                .disabled(!isButtonActive)

                Spacer()
                    .frame(height: 50)

            }
            .padding()
            .onChange(of: email) {
                checkButtonState()
            }
            .onChange(of: password) {
                checkButtonState()
            }
        }
    }

    private func checkButtonState() {
        isButtonActive = !email.isEmpty && !password.isEmpty
    }
}

// Extension to handle placeholder text in TextField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .previewDevice("iPhone 16 Pro")
    }
}

