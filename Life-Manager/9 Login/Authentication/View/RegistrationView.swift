//
//  RegistrationView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 03.06.25.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var password = ""
    @State private var confirmPasswort = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            // image
            Image(systemName: "person.2.circle.fill")
                .resizable()
                .scaledToFit( )
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Adress",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Email Adress",
                          placeholder: "name@example.com")
                
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter your Password",
                          isSecureField: true)
                
                InputView(text: $confirmPasswort,
                          title: "Confirm Password",
                          placeholder: "Confirm your Password",
                          isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            Button {
                print("Sign user up...")
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
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
