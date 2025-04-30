//
//  CalendarItemListSubview.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 30.04.25.
//

import SwiftUI

struct CalendarItemListSubview: View {
    let selectedDate: Date
    
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
                    }
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    CalendarItemListSubview(selectedDate: Date())
}
