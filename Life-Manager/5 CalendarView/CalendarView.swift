//
//  CalendarView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct CalendarView: View {
        @State var displayedMonth: Date = Date()
        @State var selectedDate: Date? = Date()
        @State private var calendarItems = CalendarItem.samples
        @State private var selectedCalendarItem: CalendarItem? = nil

        var calendar: Calendar = {
            var calendar = Calendar.current
    //        calendar.locale = Locale.autoupdatingCurrent
            calendar.locale = Locale(identifier: "de_DE")
            return calendar
        }()

        var body: some View {
            ScrollView {
                VStack(spacing: 12) {
                    // Display selected month with navigation arrows and the row of weekdays
                    WeekdayHeaderView(displayedMonth: $displayedMonth)
                    
                    // Get the array of days for the current month
                    let days = generateMonthGrid()
                    
                    // Grid that grows vertically
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 2) {
                        ForEach(days, id: \.self) { date in
                            CalendarDayCell(
                                        date: date,
                                        calendar: calendar,
                                        displayedMonth: displayedMonth,
                                        selectedDate: selectedDate,
                                        calendarItems: calendarItems
                                    )
                            // When date isn't selected, select it, otherwise unselect it
                            .onTapGesture {
                                // Check if selectedDate is set, and if it's already the same day as the date the user just tapped
                                // if let selected = selectedDate -> checks if selectedDate is non-nil, if it is, it unwraps it into a local constant called selected
                                // calendar.isDate(selected, inSameDayAs: date) -> compares just the day of two dates, returns true if selected and date fall on the same calendar day
                                if let selected = selectedDate, calendar.isDate(selected, inSameDayAs: date) {
                                    selectedDate = nil
                                } else {
                                    selectedDate = date
                                }
                            }
                        }
                    }
                    
                    Divider().padding(.top,20)
                    
                    // Display task (if a day is selected, just tasks for the day, otherwise all tasks)
                    VStack(alignment: .leading, spacing: 8) {
                        // if a day is selecte, set visibleTasks to an array of tasks for the selected day, otherwise set it to the array of all tasks
                        let visibleCalendarEntries = calendarItems.filter { calendar.isDate($0.startDate, inSameDayAs: selectedDate!) }
                        // If visibleTasks is empty, show the text "No tasks for this day"
                        if visibleCalendarEntries.isEmpty {
                            Text("Keine Einträge für diesen Tag.")
                                .foregroundColor(.gray)
                        } else {
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
                    Spacer()
                }
                .padding(10)
            }
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
                    CalendarDetailView(item: $calendarItems[index])
                        // Make the sheet oben to 40% of the screen
                        .presentationDetents([.fraction(0.4)])
                }
            }
        }
        
        // Function to generate the month grid, returns an array of 42 Dates
        // calendar.dateInterval(of:for:) -> returns the starting time and duration of a given calendar component that CONTAINS a given date
        func generateMonthGrid() -> [Date] {
            // monthInterval = start and end dates of the month containing displayedMonth -> Returns a DateInterval from the 1st of the month tothe start of the next month
            guard let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
                  // Gets the first full week that contains the first day of the month (possibly also containing days of the month before)
                  let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                  // Gets the last full week that contains the last day of the month. (Subtracts 1 second from monthInterval.end so that we're still inside the last day of the month)
                  let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
            else { return [] } // if there is an error, return an empty array
            // stride(from:to:by:) -> returns a sequence from a starting value to, but not including, an end value, stepping by the specified amount
            // 86400 = number of seconds in a day
            // Return an array of days starting from the beginning of the first week to the end of the last week
            return Array(stride(from: firstWeek.start, through: lastWeek.end, by: 86400))
        }

}

#Preview {
    CalendarView()
}
