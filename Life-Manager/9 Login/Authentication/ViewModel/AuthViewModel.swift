import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var userSession: User? // Geändert zu User?
    @Published var currentUser: User?
    @Published var userExample1: [User] = [] //Nutzen wir nicht!
    @Published var newUserGreeting: String = "Willkommen, neuer Benutzer!"

    @Published var dummyUsers: [User] = [  // @Published hinzufügen
        User(id: "C", fullname: "Christiane Roth", email:"CR@gmail.com", password: "1234"),
        User(id: "alice123", fullname: "Alice Wonderland", email: "alice@example.com", password: "securePassword1"),
        User(id: "bob456", fullname: "Bob The Builder", email: "bob.builder@example.com", password: "passwordBob"),
        User(id: "charlie789", fullname: "Charlie Chaplin", email: "charlie.c@example.com", password: "charlieSecret"),
        User(id: "diana007", fullname: "Diana Prince", email: "diana.prince@example.com", password: "wonderWomanPW"),
        User(id: "ethan_hunt", fullname: "Ethan Hunt", email: "ethan.hunt@example.com", password: "impossibleMission"),
        User(id: "fiona.g", fullname: "Fiona Goode", email: "fiona.goode@example.com", password: "supremeWitch"),
        User(id: "gordonR", fullname: "Gordon Ramsay", email: "gordon.ramsay@example.com", password: "hellsKitchenPW"),
        User(id: "hermione.g", fullname: "Hermione Granger", email: "hermione.granger@example.com", password: "magicAlways"),
        User(id: "indiana_j", fullname: "Indiana Jones", email: "indiana.jones@example.com", password: "ancientRelics"),
        User(id: "jamesBond007", fullname: "James Bond", email: "james.bond@example.com", password: "007Secret")
    ]
    init() {
    }
    func signIn(withEmail email: String, password: String) async throws {
        print("Sign in...")
        // Hier würde die echte Firebase-Anmeldung stehen, aber wir verwenden die Dummy-Authentifizierung.
    }
    func createUser(withEmail email: String, password: String, fullname: String)  {
    }
    func signOut() {
    }
    func deleteAccount() {
    }
    func fetchUser() async {
    }
    //Dummy attemptLogin funktion, email und passwort als parameter!!
    func attemptLogin(email: String, password: String) -> Bool {
        for user in dummyUsers {
            if email == user.email && password == user.password {
                // Login erfolgreich
                currentUser = user // Setze den aktuellen Benutzer
                userSession = user // Setze die User Session
                return true
            }
        }
        // Login fehlgeschlagen
        return false
    }
}
