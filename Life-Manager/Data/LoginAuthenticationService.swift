import Foundation


class AuthenticationService {
    func attemptLogin(email: String, password: String) -> Bool {
 
        
        if email == "test@example.com" && password == "password" {
            return true
        } else {
            return false
        }
    }
}


