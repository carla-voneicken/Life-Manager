//
//  CalendarLayoutPickerMenu.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 02.06.25.
//

import SwiftUI

struct CalendarLayoutPickerMenu: View {
    @Binding var isDropdownExpanded: Bool
    @Binding var selectedLayout: CalendarLayout
    
    var body: some View {
        // Transparent full-screen tap target to catch the user tapping outside the dropdown menu to hide it again
        Color.black.opacity(0.001) // almost invisible
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    isDropdownExpanded = false
                }
            }
            .zIndex(5) // below the dropdown but above other content
        
        // Dropdown rendered at top ZStack level
        VStack(alignment: .leading, spacing: 8) {
            ForEach(dropdownOptions) { option in
                HStack(spacing: 8) {
                    Image(option.icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(option.title)
                    Spacer()
                    
                    if selectedLayout == option.layout {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.vertical, 5)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        selectedLayout = option.layout
                        isDropdownExpanded = false
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 10)
        )
        .offset(x: -15, y: 60) // position of the VStack (adjust this to align properly)
        .fixedSize()
        .transition(
            .scale(scale: 0.95, anchor: .topTrailing)
            .combined(with: .opacity)
        )
        .zIndex(10) // ensure it stays on top
    }
}

#Preview {
    CalendarLayoutPickerMenu(isDropdownExpanded: .constant(true), selectedLayout: .constant(.week))
}
