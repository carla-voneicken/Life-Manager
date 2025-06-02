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
    var icon: String
    var layout: CalendarLayout
}

let dropdownOptions = [
    DropdownOption(title: "Monatsansicht", icon: "CalendarIcon30", layout: .month),
    DropdownOption(title: "Wochenansicht", icon: "CalendarIcon7", layout: .week),
    DropdownOption(title: "Tagesansicht", icon: "CalendarIcon1", layout: .day)
]
