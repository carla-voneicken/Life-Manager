//
//  CalendarView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 15.05.25.
//

import SwiftUI

enum CalendarLayout {
    case month
    case week
    case day
}


struct CalendarView: View {
    @State var selectedLayout: CalendarLayout = .week
    @State var isDropdownExpanded: Bool = false
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            VStack {
                // top row with the calendar layout picker button on the right
                HStack {
                    Spacer()
                    CalendarLayoutPickerButton(isExpanded: $isDropdownExpanded, selectedLayout: $selectedLayout)
                        .padding(.trailing, 15)
                }
                
                // display the selected calendar layout below the top row
                switch selectedLayout {
                case .month:
                    MonthlyCalendarView()
                case .week:
                    WeeklyCalendarView()
                case .day:
                    DailyCalendarView()
                }
            }
            
            // if the dropdown is expanded (when tapping the button), display the calendar layout picker menu
            if isDropdownExpanded {
                CalendarLayoutPickerMenu(isDropdownExpanded: $isDropdownExpanded, selectedLayout: $selectedLayout)
            }
        }
        .animation(.easeInOut, value: isDropdownExpanded)
    }
}



#Preview {
    CalendarView()
}
