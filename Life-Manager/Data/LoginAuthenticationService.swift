import Foundation


class AuthenticationService {
    func attemptLogin(email: String, password: String) -> Bool {
        // Hier würdest du deine echte Authentifizierungslogik implementieren
        // Zum Beispiel, eine Anfrage an einen Server senden oder Daten aus einer Datenbank abrufen
        // Für dieses Beispiel geben wir einfach true oder false basierend auf Dummy-Daten zurück
        if email == "test@example.com" && password == "password" {
            return true
        } else {
            return false
        }
    }
}


