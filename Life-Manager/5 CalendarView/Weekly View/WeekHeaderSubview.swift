//
//  WeekHeaderView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 27.04.25.
//

import SwiftUI

struct WeekNavigatorSubview: View {
    @Binding var displayedWeek: Date
    
    var daysOfWeek: [Date] {
        getDaysOfWeek(selectedWeek: displayedWeek)
    }
    
    // Function to change the month (if the calculation fails, fall back to the current value)
    private func changeWeek(by value: Int) {
        displayedWeek = calendar.date(byAdding: .weekOfYear, value: value, to: displayedWeek) ?? displayedWeek
    }
    
    
    var body: some View {
        // Left arrow - currently displayed week - right arrow (tapping arrow calls the changeMonth function)
        HStack {
            Button(action: { changeWeek(by: -1) }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            
            // Display week interval
            if calendar.isDate(daysOfWeek[0], equalTo: daysOfWeek[6], toGranularity: .month) {
                // Same month → only show full month once
                Text("\(daysOfWeek[0].day) - \(daysOfWeek[6].dayFullMonth)")
            } else {
                if calendar.isDate(daysOfWeek[0], equalTo: daysOfWeek[6], toGranularity: .year) {
                        // Different months, same year → show month on both
                    Text("\(daysOfWeek[0].dayFullMonth) - \(daysOfWeek[6].dayFullMonth)")
                    } else {
                        // Different months and year → show month and year on both
                        Text("\(daysOfWeek[0].dayFullMonthYear) - \(daysOfWeek[6].dayFullMonthYear)")
                    }
            }
            
            Spacer()
            Button(action: { changeWeek(by: 1) }) {
                Image(systemName: "chevron.right")
            }
        }
        .tint(.primary)
        .padding(.horizontal)
    }
}

