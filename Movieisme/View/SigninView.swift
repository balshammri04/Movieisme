import SwiftUI

struct SigninView: View {
    let userImage: String
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showError: Bool = false
    @State private var isButtonActive: Bool = false
    @FocusState private var focusedField: Field?
    @State private var navigateToMovieCenter: Bool = false
    @State private var loggedInUser: User? // تخزين المستخدم المسجل دخوله


    // User data
    let users: [User] = [
        User(id: "recANScdMG9yPTpsR", email: "Xxxx234@gmail.com", password: "Xxxx234@gmail.com", profileImage: "https://i.imghippo.com/files/iBgC6164yB.png", name: "Default User"),
        User(id: "recPMaNVKM6yYZFIl", email: "kaia@oconnor.com", password: "kaia@oconnor.com", profileImage: "https://source.unsplash.com/200x200/?person", name: "Default User"),
        User(id: "recPRxIRAyyvQxfkP", email: "sam@oconnor.com", password: "Sam@oconnor.com", profileImage: "https://source.unsplash.com/200x200/?person", name: "Default User"),
        User(id: "recaLvl1OOPjSagCx", email: "alia@romero.com", password: "alia@romero.com", profileImage: "https://source.unsplash.com/200x200/?person", name: "Default User")
        ]
    
    enum Field {
        case email, password
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("signin")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                // Gradient overlay
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.3)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Title and subtitle
                    NavigationLink(destination: MoviesCenterView(userImage: "https://source.unsplash.com/200x200/?person")) {
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
                        emailInputField()
                        passwordInputField()

                        if showError {
                            Text("Invalid email or password")
                                .foregroundColor(.red)
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                    // Sign-in button
                    Button(action: authenticateUser) {
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
                .onChange(of: email) { _ in checkButtonState() }
                .onChange(of: password) { _ in checkButtonState() }

                
                }
            }
        }
    }

    // MARK: - Helper Views
    @ViewBuilder
    private func emailInputField() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Email")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)

            TextField("", text: $email)
                .placeholder(when: email.isEmpty) {
                    Text("Enter your email")
                        .foregroundColor(.white.opacity(0.70))
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
             //   .focused($focusedField, equals: .email)
        }
    }

    @ViewBuilder
    private func passwordInputField() -> some View {
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
                                .foregroundColor(.white.opacity(0.70))
                        }
                } else {
                    SecureField("", text: $password)
                        .placeholder(when: password.isEmpty) {
                            Text("Enter your password")
                                .foregroundColor(.white.opacity(0.70))
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
    }

    // MARK: - Helper Methods
    private func checkButtonState() {
        isButtonActive = !email.isEmpty && !password.isEmpty
    }

    private func authenticateUser() {
            if let user = users.first(where: { $0.email == email && $0.password == password }) {
                loggedInUser = user // تخزين بيانات المستخدم
                navigateToMovieCenter = true
                showError = false
            } else {
                showError = true
            }
        }
    }


// Extension for Placeholder
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
        NavigationView {
            SigninView(userImage: "")
        }
    }
}

