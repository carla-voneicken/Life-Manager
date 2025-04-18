//
//  FamilyMember.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 18.04.25.
//
import SwiftUI

struct FamilyMember: Identifiable {
    var id: UUID = UUID()
    var name: String
    var color: Color
    var admin: Bool = false
    var profilePicture: Image?
    
    static var familyMembers: [FamilyMember] =
        [
            FamilyMember(
                name: "Mama",
                color: .red,
                admin: true
            ), FamilyMember(
                name: "Papa",
                color: .red,
                admin: true
            ), FamilyMember(
                name: "Sophie",
                color: .red,
                admin: true
            ), FamilyMember(
                name: "Ben",
                color: .red,
                admin: true
            )
        ]
            
}
