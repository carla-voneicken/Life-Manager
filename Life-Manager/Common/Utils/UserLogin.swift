//
//  User.swift
//  Life-Manager
//
//  Created by Christiane Roth on 04.06.25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let password: String?
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Christiane Roth", email: "christiane.roth@example.com", password: "test")
}
