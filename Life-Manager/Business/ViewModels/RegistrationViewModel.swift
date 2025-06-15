import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var fullname = ""
    @Published var password = ""
    @Published var confirmPasswort = ""
    @Published var registrationSuccess = false
    @Published var registrationError: RegistrationError? = nil
    private let registrationService = RegistrationService()  // Instanz des Services
    @EnvironmentObject var authViewModel: AuthViewModel
    func register() {
        do {
            try registrationService.registerUser(email: email, fullname: fullname, password: password, confirmPassword: confirmPasswort)
            registrationSuccess = true
            //Hier nach erfolgreicher Regi zum loginScreen wechseln
        } catch {
            registrationError = error as? RegistrationError
            registrationSuccess = false
        }
    }
}
