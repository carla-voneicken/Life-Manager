// SigninButtonView.swift
import SwiftUI
struct SigninButtonView: View {
    @Binding var email: String
    @Binding var password: String
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var loginFailed: Bool // Use Binding
    
    var body: some View {
        Button(action: {
            if viewModel.attemptLogin(email: email, password: password) {
                print("Dummy user logged in successful")
                
                Task {
                    try await viewModel.signIn(withEmail: email, password: password)
                    print("Log user in..")
                }
            } else {
                loginFailed = true // Set the bound variable
            }
        }, label: {
            HStack {
                Text("SIGN IN")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            .background(Color(.systemBlue))
            .cornerRadius(10)
        }) // Closure für Button abschließen
    }
}
