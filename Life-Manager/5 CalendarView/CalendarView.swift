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
    
    // control if option icon should be shown or not
    var showIcon: Bool = true
    
    // stores the width of the dropdown button so that we can align the menu properly with it
    @State var menuWidth: CGFloat = 0
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            VStack {
                HStack {
                    Spacer()
                    CalendarLayoutPickerButton(isExpanded: $isDropdownExpanded, selectedLayout: $selectedLayout)
                        .tint(.primary).frame(height: 50)
                        .frame(width: menuWidth, height: 50, alignment: .trailing)
                        .padding(.trailing, 15)
                        .background(
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppear {
                                        menuWidth = proxy.size.width
                                    }
                            }
                        )
                }
                
                switch selectedLayout {
                case .month:
                    MonthlyCalendarView()
                case .week:
                    WeeklyCalendarView()
                case .day:
                    DailyCalendarView()
                }
            }
            // Transparent full-screen tap target to catch the user tapping outside the dropdown menu to hide it again
            if isDropdownExpanded {
                Color.black.opacity(0.001) // almost invisible
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isDropdownExpanded = false
                        }
                    }
                    .zIndex(5) // below the dropdown but above other content
            }
            
            // Dropdown rendered at top ZStack level
            if isDropdownExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(dropdownOptions) { option in
                        HStack(spacing: 8) {
                            if showIcon {
                                Image(option.icon)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            Text(option.title)
                            Spacer()
                            if selectedLayout == option.layout {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.vertical, 5)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                selectedLayout = option.layout
                                isDropdownExpanded = false
                            }
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.2), radius: 10)
                )
                .offset(x: -15, y: 60) // Adjust this to align properly
                .fixedSize()
                .transition(
                    .scale(scale: 0.95, anchor: .topTrailing)
                    .combined(with: .opacity)
                )
                .zIndex(10) // 🔥 Ensure it stays on top
            }
        }
        .animation(.easeInOut, value: isDropdownExpanded)
    }
}



#Preview {
    CalendarView()
}
