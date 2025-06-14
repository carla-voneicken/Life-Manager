//
//  Mission.swift
//  Life-Manager
//
//  Created by Christiane Roth on 12.05.25.
//
import SwiftUI

class Mission: Identifiable, ButtonData, ObservableObject, Equatable {
    let id = UUID()
    @Published var name: String
    @Published var color: Color
    @Published var items: [Task] = []
    init(name: String, color: Color? = nil) {
        self.name = name
        self.color = color ?? .randomColor()
    }
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
}
struct Task: Identifiable {
    let id = UUID()
    var name: String
}

