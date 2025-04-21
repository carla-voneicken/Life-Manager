//
//  WeekdayHeaderView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 21.04.25.
//

import SwiftUI

struct WeekdayHeaderView: View {
    @Binding var displayedMonth: Date
    
    // Users current calendar settings (e.g. locale and first day of the week)
    var calendar: Calendar = {
        var calendar = Calendar.current
//        calendar.locale = Locale.autoupdatingCurrent
        calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
        return calendar
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // full month name and year
        formatter.locale = Locale(identifier: "de_DE") // get the German month names
        return formatter
    }()
    
    // Array of short names for weekdays (Sunday is the first day by default, that's why we add it at the end)
    var weekdays: [String] {
        let symbols = calendar.shortStandaloneWeekdaySymbols
        return Array(symbols[1...6] + [symbols[0]])
    }
    
    // Index of the current weekday (subtract 1, because .weekdays starts at 1 (1 = Sunday))
    // Example: originalIndex for Wednesday = 4 - 1 = 3 -> (3 + 6) % 7 = 9 % 7 = 2 -> index of Wednesday in the array [Mon, Tue, Wed, ...]
    var todayWeekdayIndex: Int {
        let originalIndex = calendar.component(.weekday, from: Date()) - 1
        return (originalIndex + 6) % 7
    }
    
    // Function to change the month (if the calculation fails, fall back to the current value)
    private func changeMonth(by value: Int) {
        displayedMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) ?? displayedMonth
    }
    
    var body: some View {
        VStack(spacing: 24) {

            // Left arrow - currently displayed month - right arrow (tapping arrow calls the changeMonth function)
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(formatter.string(from: displayedMonth))
                    .font(.headline)
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .tint(.primary)
            .padding(.horizontal)
            
            // Display of days of the week
            HStack(spacing: 2) {
                ForEach(weekdays.indices, id: \.self) { index in
                    Text(weekdays[index])
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity) // make each day take equal space in the row
                    
                        .foregroundColor(index == todayWeekdayIndex ? .primary : .gray) // if index matches today, set text color to primary, otherwise grey
                        .padding(.vertical, 3)
                    
                        .background(index == todayWeekdayIndex ? .gray.opacity(0.4) : .gray.opacity(0.2), in:.rect(cornerRadius: 8)) // if index matches today, set background to a higher opacity to highlight it, otherwise darker opacity grey
                }
            }
        }
    }
}
