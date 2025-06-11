//
//  DayCellView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 21.04.25.
//

import SwiftUI

struct CalendarDayCellSubview: View {
    let date: Date
    let calendar: Calendar
    let displayedMonth: Date
    let selectedDate: Date?
    let calendarItems: [CalendarItem]
    
    var body: some View {
        // Check if the date belongs to the current month or to the previous or next month
        // isDate(_:equalTo:toGranularity:) -> returns a Boolean value indicating whether two dates are equal down to the specified component
        let isCurrentMonth = calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
        
        // Get tasks for this specific date (only filter tasks who's date is the same as date)
        let tasksForDay = CalendarItem.samples.filter { calendar.isDate($0.startDate, inSameDayAs: date) }
        
        // Check if the date is currently selected by the user
        let isSelected = selectedDate != nil && calendar.isDate(selectedDate!, inSameDayAs: date)
        
        // Each day is shown as a vertical stack
        VStack(spacing: 4) {
            // Display the day (aka the number)
            Text("\(calendar.component(.day, from: date))")
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, minHeight: 45)
            
                // If the day is currently selected by the user, display it in the custom color .se, otherwise if it is the currentMonth, use .primary, if it's not use .gray as the text color
                .foregroundColor(isSelected ? .se : (isCurrentMonth ? .primary : .gray ))
                // If the day is currently selected, use primary color as the background, otherwise if it is the currentMonth, use custom color .BG, if not use .gray
                .background(isSelected ? Color.primary : (isCurrentMonth ? .BG : .gray.opacity(0.2)))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
                // Highlight today with a border (on the other days the border is clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Calendar.current.isDateInToday(date) ? Color.primary : .clear)
                        .padding(1)
                }
            
                // Show dots in the day cell to represent the number of tasks for that day (maximum 5 dots)
                .overlay(alignment: .bottom) {
                    HStack(spacing: 3) {
                        // min(tasksForDay.count, 5) returns the number of tasks for the day, if it is smaller than 5, otherwise returns 5
                        ForEach(0..<min(tasksForDay.count, 5), id: \.self) { _ in
                            Circle()
                                .frame(width: 4, height: 4).padding(.bottom,6)
                                .foregroundStyle(isSelected ? .se : .primary)
                        }
                    }
                }
        }
    }
}
