//
//  CalendarDetailView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct CalendarItemDetailView: View {
    @Binding var item: CalendarItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: Titel
            TextField("Titel", text: $item.title)
                .font(.largeTitle)
                .bold()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // MARK: Time
            // DatePicker for startDate
            DatePicker("Start:", selection: $item.startDate, displayedComponents: [.date, .hourAndMinute])
                // When the etartDate is changed, automatically change the day of the endDate as well
                .onChange(of: item.startDate) { _, newStart in
                    var updatedItem = item // make a mutable copy
                    // Get the time of the endDate (we don't want to change that)
                    let endDateComponents = Calendar.current.dateComponents([.hour, .minute], from: item.endDate)
                    // Create a new endDate using the newStart date as the base and changing the hour/minute/second to the time of the endDate
                    if let newEnd = Calendar.current.date(
                        bySettingHour: endDateComponents.hour ?? 0,
                        minute: endDateComponents.minute ?? 0,
                        second: 0,
                        of: newStart) {
                            // Because item is a binding of a struct CalendarItem, we can't change it's variables directly, so instead we're creating a temporary copy (updatedItem) and then assigning that copy to the item
                            updatedItem.endDate = newEnd
                            item = updatedItem
                        }
                }
     
            // DatePicker for endDate
            DatePicker("Ende:", selection: $item.endDate, displayedComponents: [.date, .hourAndMinute])


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
        CalendarItemDetailView(item: item)
    }
}
