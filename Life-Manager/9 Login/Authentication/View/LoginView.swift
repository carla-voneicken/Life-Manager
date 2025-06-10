//
//  LoginView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 03.06.25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var loginFailed: Bool = false
    @State private var dummyUsers: [User] = []
    @State private var user: User?

    
    var body: some View {
       NavigationStack {
           VStack {
    
               LoginImageView()
               

               VStack(spacing: 24) {
                   InputView(text: $email,
                             title: "Email Adress",
                             placeholder: "name@example.com")
                   .autocapitalization(.none)
                   
                   InputView(text: $password,
                             title: "Password",
                             placeholder: "Enter your Password",
                             isSecureField: true)
                   .autocapitalization(.none)
                   
               }
               .padding(.horizontal)
               .padding(.top, 12)
               
               
               
               SigninButtonView(email: $email, password: $password, viewModel: _viewModel, loginFailed: $loginFailed)
               }
           
               .padding(.top, 24)
               Spacer()
        
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
           .alert(isPresented:$loginFailed) {
               Alert(
                title: Text("Login Failed"), message: Text("Invalid email or password"), dismissButton: .default(Text("OK"))
               )
           }
        }
        
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        return LoginView()
            .environmentObject(authViewModel)
       
    }
}
