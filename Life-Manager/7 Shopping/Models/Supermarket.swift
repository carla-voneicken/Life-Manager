//
//  Supermarket.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI


// Stellt einen Supermarkt dar, der eine Liste von Items und eine Farbe hat.


class Supermarket: Identifiable, ObservableObject, Equatable {
    let id = UUID()
    @Published var name: String
    @Published var items: [Item] = []
    @Published var color: Color
    init(name: String, color: Color = Color.randomColor()) {
        self.name = name
        self.color = color
    }
    static func == (lhs: Supermarket, rhs: Supermarket) -> Bool {
        return lhs.id == rhs.id
    }
}
