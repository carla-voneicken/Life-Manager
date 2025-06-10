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
    @StateObject var viewModel = AuthViewModel()
    @State private var errorMessage: String?
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            
            LoginImageView()
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Adress",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Full name",
                          placeholder: "first Name, last Name")
                
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
            
            Button() {
                isLoading = true
                #if DEBUG
                print("RegistrationView: Registrierung gestartet mit E-Mail: \(email), Fullname: \(fullname)")
                #endif
                Task {
                    do {
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                        #if DEBUG
                        print("RegistrationView: Registrierung erfolgreich!")
                        #endif
                    } catch AuthViewModel.AuthError.missingEmail {
                        errorMessage = "E-Mail fehlt"
                        #if DEBUG
                        print("RegistrationView: E-Mail fehlt")
                        #endif
                        showAlert = true
                    } catch AuthViewModel.AuthError.invalidEmail {
                        errorMessage = "Ungültige E-Mail"
                        #if DEBUG
                        print("RegistrationView: Ungültige E-Mail")
                        #endif
                        showAlert = true
                    } catch AuthViewModel.AuthError.weakPassword {
                        errorMessage = "Schwaches Passwort"
                        #if DEBUG
                        print("RegistrationView: Schwaches Passwort")
                        #endif
                        showAlert = true
                    } catch AuthViewModel.AuthError.emailAlreadyExists {
                        errorMessage = "E-Mail bereits vorhanden"
                        #if DEBUG
                        print("RegistrationView: E-Mail bereits vorhanden")
                        #endif
                        showAlert = true
                    } catch { // Generischer catch-Block für *alle* anderen Fehler
                        errorMessage = "Ein unbekannter Fehler ist aufgetreten: \(error)" // Bessere Fehlermeldung
                        #if DEBUG
                        print("RegistrationView: Unerwarteter Fehler bei der Registrierung: \(error)")
                        #endif
                        showAlert = true
                    }
                    isLoading = false
                }
            
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
            .disabled(isLoading) // Button deaktivieren während des Ladens
                      if isLoading {
                          ProgressView() // Ladeindikator
                              .padding(.top, 8)
                      }
            
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
