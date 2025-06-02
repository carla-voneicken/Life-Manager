//
//  CalendarLayoutPickerButton.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 02.06.25.
//

import SwiftUI

struct CalendarLayoutPickerButton: View {
    @Binding var isExpanded: Bool
    @Binding var selectedLayout: CalendarLayout
    
    var icon: String {
        switch selectedLayout {
            case .month: return "CalendarIcon30"
            case .week: return "CalendarIcon7"
            case .day: return "CalendarIcon1"
            }
    }
    
    var body: some View {
        Button(action: {
            isExpanded.toggle()
        }) {
            // button with icon and a circular background with a soft shadow
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25) // icon size
                .padding(10)
                .background(.gray.opacity(0.3), in: .circle)
                .frame(width: 40, height: 40) // overall circle size
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
        }
    }
}

#Preview {
    CalendarLayoutPickerButton(isExpanded: .constant(false), selectedLayout: .constant(.month))
}
