

import SwiftUI

struct LoginViewTest: View {
    @StateObject private var viewModel = LoginViewModel(authService: AuthenticationService())
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(authService: AuthenticationService = AuthenticationService()) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(authService: authService))
    }
    
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
                   
                   
                   // image
           //        LoginImageView()
                   
                   // form fields
                   VStack(spacing: 24) {
                    
                       InputView(text: $viewModel.email,
                                 title: "Email Adress",
                                 placeholder: "name@example.com")
                       .autocapitalization(.none)
                       
                       InputView(text: $viewModel.password,
                                 title: "Password",
                                 placeholder: "Enter your Password",
                                 isSecureField: true)
                       
                   }
                   .padding(.horizontal)
                   .padding(.top, 12)
                   
                   //sign in button
                   Button {
                       viewModel.login()
                   } label: {
                       HStack {
                           Text("SIGN IN")
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
                   // sign in button
                   NavigationLink {
                       RegistrationView()
                           .navigationBarBackButtonHidden(true)
                   } label: {
                       HStack(spacing: 3) {
                           Text("Don't have an account?")
                           Text("Sign Up")
                               .fontWeight(.bold)
                       }
                       .font(.system(size: 14))
                   }
                   
               }
               .padding(.top, 250)
               .alert(isPresented:$viewModel.loginFailed) {
                   Alert(
                    title: Text("Login Failed"), message: Text("Invalid email or password"), dismissButton: .default(Text("OK"))
                   )
               }
               .background(
                Color.white.opacity(0.3)
                    .ignoresSafeArea()
               )
           }
        }
    }
}
struct LoginViewTest_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        return LoginView()
            .environmentObject(authViewModel)
       
    }
}

