//
//  CalendarItemListSubview.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 30.04.25.
//

import SwiftUI

struct CalendarItemListSubview: View {
    let selectedDate: Date
    @State private var calendarItems = CalendarItem.samples
    @State private var selectedCalendarItem: CalendarItem? = nil

    
    var body: some View {
        // Display task (if a day is selected, just tasks for the day, otherwise all tasks)
        VStack(alignment: .leading, spacing: 8) {
            // if a day is selecte, set visibleTasks to an array of tasks for the selected day, otherwise set it to the array of all tasks
            let visibleCalendarEntries = CalendarItem.samples.filter { calendar.isDate($0.startDate, inSameDayAs: selectedDate) }
            // If visibleTasks is empty, show the text "No tasks for this day"
            if visibleCalendarEntries.isEmpty {
                Text("Keine Einträge für diesen Tag.")
                    .foregroundColor(.gray)
            } else {
                Text("Termine für \(selectedDate.dayShortMonthYear):")
                    .font(.headline)
                // Otherwise display all the tasks from the array (each containing the name and a circle)
                ForEach(visibleCalendarEntries) { entry in
                    HStack{
                        CalendarItemView(item: entry)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0 , y: 2)
                            )
                            .padding(.vertical, 4)
                            .onTapGesture {
                                selectedCalendarItem = entry
                            }
                    }
                }
            }
        }
        .padding(.top)
        // MARK: Modal sheet for calendar items
        .sheet(isPresented: Binding<Bool>(
            // Handle the sheet logic to display the sheet when the selected item is not nil (get:) and set it to nil once the sheet is dismissed (set:)
            get: { selectedCalendarItem != nil },
            // $0 is the Boolean value that SwiftUI provides when the sheet is being presented (true) or dismissed (false)
            set: { if !$0 { selectedCalendarItem = nil } }
        )) {
            // Only if the selectedCalendarItem exists and the index for that item in the calendarItemsToday array exists, run the code to open the sheet
            if let selected = selectedCalendarItem,
               let index = calendarItems.firstIndex(where: { $0.id == selected.id }) {
                // CalendarDetailView takes a binding to a certain item (specified by the index) to make it editable
                CalendarItemDetailView(item: $calendarItems[index])
                    // Make the sheet oben to 40% of the screen
                    .presentationDetents([.fraction(0.4)])
            }
        }
    }
}

#Preview {
    CalendarItemListSubview(selectedDate: Date())
}
