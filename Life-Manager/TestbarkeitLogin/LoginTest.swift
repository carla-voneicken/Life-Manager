//
//  LoginTest.swift
//  Life-Manager
//
//  Created by Christiane Roth on 14.06.25.
//
/*
import XCTest

@testable import Life_Manager // Ersetze Life_Manager mit deinem Projektnamen
class LoginViewModelTests: XCTestCase {
    func testLoginSuccess() {
        let authService = AuthenticationService()
        let viewModel = LoginViewModel(authService: authService)
        viewModel.email = "test@example.com"
        viewModel.password = "password"
        let expectation = XCTestExpectation(description: "Login should succeed")
        viewModel.login()
        // Gib dem asynchronen Prozess etwas Zeit, um abzuschließen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(viewModel.loginFailed, "Login should not fail")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
    func testLoginFailure() {
        let authService = AuthenticationService()
        let viewModel = LoginViewModel(authService: authService)
        viewModel.email = "wrong@example.com"
        viewModel.password = "wrongpassword"
        let expectation = XCTestExpectation(description: "Login should fail")
        viewModel.login()
        // Gib dem asynchronen Prozess etwas Zeit, um abzuschließen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(viewModel.loginFailed, "Login should fail")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
*/
