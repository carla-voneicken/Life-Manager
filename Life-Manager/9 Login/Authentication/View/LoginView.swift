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
    
    var body: some View {
       NavigationStack {
           VStack {
               // image
               Image(systemName: "person.2.circle.fill")
                   .resizable()
                   .scaledToFit( )
                   .frame(width: 100, height: 120)
                   .padding(.vertical, 32)
               
               // form fields
               VStack(spacing: 24) {
                   InputView(text: $email,
                             title: "Email Adress",
                             placeholder: "name@example.com")
                   .autocapitalization(.none)
                   
                   InputView(text: $password,
                             title: "Password",
                             placeholder: "Enter your Password",
                             isSecureField: true)
                   
               }
               .padding(.horizontal)
               .padding(.top, 12)
               
               //sign in button
               Button {
                   print("Log user in..")
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
        }
        
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
