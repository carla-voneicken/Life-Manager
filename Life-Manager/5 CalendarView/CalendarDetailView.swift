//
//  CalendarDetailView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct CalendarDetailView: View {
    @Binding var item: CalendarItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: Titel
            TextField("Titel", text: $item.title)
                .font(.largeTitle)
                .bold()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // MARK: Time
//            TextField("Uhrzeit", text: $item.startDate)
//                .font(.subheadline)
//                .bold()
//                .textFieldStyle(RoundedBorderTextFieldStyle())

            // MARK: Description
            // Creating a custom Binding<String> manually using get and set closures to work around the fact that item.description is optional (String?), but TextEditor needs a non-optional String
            TextEditor(text: Binding(
                // If item.description is nil, return an empty string ("") for the editor to display
                get: { item.description ?? "" },
                // If the user types something, set item.description = new text; if they delete everything, set item.description = nil
                set: { item.description = $0.isEmpty ? nil : $0 }
            ))
            .frame(height: 30)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
            .font(.subheadline)
            
            // MARK: Location
            TextEditor(text: Binding(
                get: { item.location ?? "" },
                set: { item.location = $0.isEmpty ? nil : $0 }
            ))
            .frame(height: 60)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
            .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    StatefulPreviewWrapper(
        CalendarItem(
            title: "Zahnarzt",
            description: "Prophylaxe",
            startDate: stringToDate(dateString: "2025-04-21", timeString: "09:00")!,
            endDate: stringToDate(dateString: "2025-04-21", timeString: "10:00")!,
            location: "Praxis Zeit für schöne Zähne",
            participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[2]]
        )
    ) { item in
        CalendarDetailView(item: item)
    }
}
