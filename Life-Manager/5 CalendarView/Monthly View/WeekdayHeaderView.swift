//
//  WeekdayHeaderView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 21.04.25.
//

import SwiftUI

struct WeekdayHeaderView: View {
    
    // Users current calendar settings (e.g. locale and first day of the week)
    var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
        return calendar
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
    
    
    var body: some View {
        
        // Display of days of the week
        HStack(spacing: 2) {
            ForEach(weekdays.indices, id: \.self) { index in
                Text(weekdays[index])
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity) // make each day take equal space in the row
                
                    .padding(.vertical, 5)
                    .background(.gray.opacity(0.2), in:.rect(cornerRadius: 8))
            }
            
        }
    }
}
