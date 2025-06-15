//
//  Test.swift
//  Life-Manager
//
//  Created by Christiane Roth on 14.06.25.
//

import SwiftUI


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullName = ""
    @Published var loginFailed = false
    private let authService: AuthenticationService
    init(authService: AuthenticationService) {
        self.authService = authService
    }
    func login() {
        if authService.attemptLogin(email: email, password: password) {
            //Login erfolgreich
        } else {
            loginFailed = true
        }
    }
}
