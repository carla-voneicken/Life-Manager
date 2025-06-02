//
//  DropdownOption.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 02.06.25.
//

import SwiftUI

// Creating datatype for DropdownOption
struct DropdownOption: Identifiable {
    let id = UUID()
    var title: String
    var color: Color = .primary
    var icon: String
    var action: () -> Void
}
