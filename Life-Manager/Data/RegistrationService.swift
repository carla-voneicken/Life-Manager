// RegistrationService.swift
// Life-Manager
// Created by Christiane Roth on 15.06.25.
import Foundation


enum RegistrationError: Error, Identifiable {
    case passwordsDoNotMatch
    case missingFields
    case passwordTooShort
    case invalidEmail
    var id: Self { self }

}
class RegistrationService {
 

    func registerUser(email: String, fullname: String, password: String, confirmPassword: String) throws {
        
        guard password == confirmPassword else {
            throw RegistrationError.passwordsDoNotMatch
        }
        guard !email.isEmpty && !fullname.isEmpty && !password.isEmpty else {
            throw RegistrationError.missingFields
        }
        guard password.count >= 6 else {
            throw RegistrationError.passwordTooShort
        }
        guard isValidEmail(email: email) else {
            throw RegistrationError.invalidEmail
        }
        //guard.... Registrierung, speichern in der Datenbank, senden der Bestätigungs-Email, Erstellen des Benutzerprofils

        print("Benutzer \(fullname) mit E-Mail \(email) erfolgreich registriert!")
    }
  
    private func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
