//
//  Color+Extensions.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI
extension Color {
    // Erzeugt eine zufällige Farbe
   // aktuell beim hinzufügen eines neuen Supermarktes
    
    static func randomColor() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}
