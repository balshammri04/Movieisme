import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showError: Bool = false
    @State private var isButtonActive: Bool = false
    @State private var errorMessage: String = ""
    @FocusState private var focusedField: Field?
    
    @State private var isLoading: Bool = false
    
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
                   
                        TextField("Enter your email", text: $email)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.white.opacity(0.80))
                            .cornerRadius(8)
                            .foregroundColor(.black)
                        
                        // Password label and field
                        HStack {
                            if isPasswordVisible {
                                TextField("Enter your password", text: $password)
                            } else {
                                SecureField("Enter your password", text: $password)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.80))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        
                        // Error message
                        if showError {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // Sign-in button
                    Button(action: {
                        signIn()
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        } else {
                            Text("Sign in")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isButtonActive ? Color.yellow : Color.gray)
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                    }
                    .disabled(!isButtonActive)
                    
                    Spacer()
                        .frame(height: 50)
                }
                .padding()
                .onChange(of: email) { _ in
                    checkButtonState()
                }
                .onChange(of: password) { _ in
                    checkButtonState()
                }
                
            }
        }
        
        private func checkButtonState() {
            isButtonActive = !email.isEmpty && !password.isEmpty
        }
        
        private func signIn() {
            guard let url = URL(string: "https://api.airtable.com/v0/appsfcB6YESLj4NCN/users") else {
                self.errorMessage = "Invalid API URL"
                self.showError = true
                return
            }
            
            isLoading = true
            showError = false
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("pat174iMzI1IjVaWW.ee3816d9d6dad6782fb6e502392173de3ed73a05546fe5a1068dfaab9056f997", forHTTPHeaderField: "Authorization") // Replace with your Airtable API key
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    isLoading = false
                    
                    if let error = error {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                        self.showError = true
                        return
                    }
                    
                    guard let data = data else {
                        self.errorMessage = "No data received"
                        self.showError = true
                        return
                    }
                    
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        if let user = users.first(where: { $0.email == email && $0.password == password }) {
                            // Successful login
                            print("Welcome \(user.name)")
                        } else {
                            self.errorMessage = "Invalid credentials"
                            self.showError = true
                        }
                    } catch {
                        self.errorMessage = "Invalid password"
                        self.showError = true
                    }
                }
            }.resume()
        }
    }
    
    struct SignInView_Previews: PreviewProvider {
        static var previews: some View {
            SignInView()
                .previewDevice("iPhone 16 Pro")
        }
    }

