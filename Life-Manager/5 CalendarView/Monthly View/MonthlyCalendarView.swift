//
//  CalendarView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct MonthlyCalendarView: View {
    @State var todaysDate: Date = Date()
    @State var selectedDate: Date = Date()
    @State var displayedMonth: Date = Date()
    
    var daysOfWeek: [Date] {
        getDaysOfWeek(selectedWeek: todaysDate)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // Display selected month with navigation arrows and the row of weekdays
                MonthHeaderView(displayedMonth: $displayedMonth)
                
                // Get the array of days for the current month
                let days = getMonthGridDates()
                
                // Grid that grows vertically
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 2) {
                    
                    // Weekdays
                    ForEach(daysOfWeek, id: \.self) { date in
                        Text(date.weekday.prefix(2))
                            .frame(height: 30)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                    }
                    
                    ForEach(days, id: \.self) { date in
                        CalendarDayCell(
                            date: date,
                            calendar: calendar,
                            displayedMonth: displayedMonth,
                            selectedDate: selectedDate,
                            calendarItems: CalendarItem.samples
                        )
                        // When date isn't selected, select it, otherwise unselect it
                        .onTapGesture {
                            // Check if selectedDate is the same day as the date the user just tapped, if yes, we deselect it by setting it back to todaysDate, otherwise we select it by setting selectedDate to the tapped date
                            // calendar.isDate(selected, inSameDayAs: date) -> compares just the day of two dates, returns true if selected and date fall on the same calendar day
                            if calendar.isDate(selectedDate, inSameDayAs: date) {
                                selectedDate = todaysDate
                            } else {
                                selectedDate = date
                            }
                        }
                    }
                }
                
                Divider().padding(.top, 20)
                
                CalendarItemListSubview(selectedDate: selectedDate)
                Spacer()
            }
            .padding(10)
        }
    }
    
    // Function to generate the month grid, returns an array for the days that should be displayed (35 or 42 days, depending on the month)
    // calendar.dateInterval(of:for:) -> returns the starting time and duration of a given calendar component that CONTAINS a given date
    func getMonthGridDates() -> [Date] {
        // monthInterval = start and end dates of the month containing displayedMonth -> Returns a DateInterval from the 1st of the month to the start of the next month
        guard let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
              // Gets the first full week that contains the first day of the month (possibly also containing days of the month before)
              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              // Gets the last full week that contains the last day of the month. (Subtracts 1 second from monthInterval.end so that we're still inside the last day of the month)
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else { return [] } // if there is an error, return an empty array
        // stride(from:to:by:) -> returns a sequence from a starting value to an end value, stepping by the specified amount
        // Because lastWeek.end actually points to the first second AFTER the last week, we have to subtract 3601 seconds to stay within the targeted week (3600 is to account for the hour added in October, in all other month subtracting 1 second would suffice)
        // 86400 = number of seconds in a day
        // Return an array of days starting from the beginning of the first week to the end of the last week
        return Array(stride(from: firstWeek.start, through: lastWeek.end - 3601, by: 86400))
    }
}

#Preview {
    MonthlyCalendarView()
}
