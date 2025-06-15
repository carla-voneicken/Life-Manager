import SwiftUI
struct RegistrationViewScreen: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    Image("AppIconImage")
                    
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size .width, height: geometry.size.height)
                        .clipped()
                        .opacity(0.3)
                        .ignoresSafeArea()
                    
                }
                VStack(spacing: 48) {
                    
                    VStack(spacing: 24) {
                        // image
               //         LoginImageView()
                        VStack(spacing: 12) {
                            InputView(text: $viewModel.email,
                                      title: "Email Adress",
                                      placeholder: "name@example.com")
                            .autocapitalization(.none)
                            InputView(text: $viewModel.fullname,
                                      title: "Full name",
                                      placeholder: "first Name, last Name")
                            InputView(text: $viewModel.password,
                                      title: "Password",
                                      placeholder: "Enter your Password",
                                      isSecureField: true)
                            InputView(text: $viewModel.confirmPasswort,
                                      title: "Confirm Password",
                                      placeholder: "Confirm your Password",
                                      isSecureField: true)
                        }
                        .padding(.horizontal)
                        .padding(.top, 24)
                        
                        
                        Button {
                            viewModel.register()
                        } label: {
                            HStack {
                                Text("SIGN UP")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        }
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                        .padding(.top, 24)
                        Spacer()
                        Button {
                            authViewModel.showRegistration = false  // Beispiel: Zurück zum Login
                        } label: {
                            HStack(spacing: 3) {
                                Text("Already have an account?")
                                Text("Sign In")
                                    .fontWeight(.bold)
                            }
                            .font(.system(size: 14))
                        }
                    }
                    .padding(.top, 250)
                    .alert(item: $viewModel.registrationError) { error in
                        Alert(title: Text("Registrierungsfehler"),
                              message: Text(error.localizedDescription),
                              dismissButton: .default(Text("OK")))
                    }
                    .background(Color.white.opacity(0.3)
                        .ignoresSafeArea()
                    )
                }
            }
        }
    }
}

struct RegistrationViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        return RegistrationViewScreen()
            .environmentObject(authViewModel)
    }
}
