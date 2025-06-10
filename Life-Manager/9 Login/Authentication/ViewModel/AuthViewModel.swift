import SwiftUI
class AuthViewModel: ObservableObject {
    @Published var userSession: User?
    @Published var currentUser: User?
    @Published var showRegistration: Bool = false
    @Published var loginError: String? = nil
    @Published var dummyUsers: [User] = [
        User(id: "C", fullname: "Christiane Roth", email:"CR@gmail.com", password: "1234"),
        User(id: "alice123", fullname: "Alice Wonderland", email: "alice@example.com", password: "securePassword1"),
        User(id: "bob456", fullname: "Bob The Builder", email: "bob.builder@example.com", password: "passwordBob"),
        User(id: "indiana_j", fullname: "Indiana Jones", email: "indiana.jones@example.com", password: "ancientRelics"),
        User(id: "jamesBond007", fullname: "James Bond", email: "james.bond@example.com", password: "007Secret")
    ]
    init() {}
    func signIn(withEmail email: String, password: String) async throws {
        print("Sign in...")
    }
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        #if DEBUG
        print("AuthViewModel.createUser: Starte createUser mit E-Mail: \(email), Fullname: \(fullname)")
        #endif
        do {
            try validateEmail(email)
            try validatePassword(password)
            try validateFullname(fullname)
            #if DEBUG
            print("AuthViewModel.createUser: Validierungen erfolgreich bestanden")
            #endif
            if dummyUsers.contains(where: { $0.email == email }) {
                print("Email already exists.")
                throw AuthError.emailAlreadyExists
            }
            // **Nur hier** wird der neue Benutzer erstellt, wenn alle Validierungen erfolgreich sind
            let newUser = User(id: UUID().uuidString, fullname: fullname, email: email, password: password)
            dummyUsers.append(newUser)
            print("User \(newUser.fullname) generated successfully.")
        } catch {
            // Hier Fehler behandeln, z.B. loggen oder einen anderen Fehler werfen
            print("Validierungsfehler in createUser: \(error)")
            throw error // **WICHTIG: Den Fehler weiterwerfen!**
        }
        
    }
    private func validateEmail(_ email: String) throws {
        guard !email.isEmpty else {
            throw AuthError.missingEmail
        }
        if !email.contains("@") {
            throw AuthError.invalidEmail
        }
    }
    private func validatePassword(_ password: String) throws {
        guard !password.isEmpty else {
            throw AuthError.missingPassword
        }
        guard password.count >= 8 else {
            throw AuthError.shortPassword
        }
    }
    private func validateFullname(_ fullname: String) throws {
        guard !fullname.isEmpty else {
            throw AuthError.missingFullname
        }
    }
    func signOut() {}
    func deleteAccount() {}
    func fetchUser() async {}
    //Dummy attemptLogin funktion, email und passwort als parameter!!
    func attemptLogin(email: String, password: String) -> Bool {
        for user in dummyUsers {
            if email == user.email && password == user.password {
                // Login erfolgreich
                currentUser = user // Setze den aktuellen Benutzer
                userSession = user // Setze die User Session
                loginError = nil
                showRegistration = false
                return true
            }
        }
        showRegistration = true
        loginError = ""
        return false
    }
    enum AuthError: Error {
        case missingEmail
        case invalidEmail
        case missingPassword
        case shortPassword
        case missingFullname
        case emailAlreadyExists
        case weakPassword
    }
}
