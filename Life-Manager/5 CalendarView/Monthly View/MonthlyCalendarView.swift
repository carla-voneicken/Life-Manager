//
//  CalendarView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct MonthlyCalendarView: View {
    @State var selectedDate: Date = Date()
    @State var displayedMonth: Date = Date()
    
    // dragOffset: tracks the horizontal drag distance, to allow moving the content when the user swipes (0 is the neutral, undragged position)
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        
        let months = [
            Calendar.current.date(byAdding: .month, value: -1, to: displayedMonth)!,
            displayedMonth,
            Calendar.current.date(byAdding: .month, value: 1, to: displayedMonth)!
        ]
        
        VStack(spacing: 12) {
            // Display selected month with navigation arrows and the row of weekdays
            MonthNavigatorSubview(displayedMonth: $displayedMonth)
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(months, id: \.self) { month in
                        MonthlyCalendarGridSubview(displayedMonth: $displayedMonth, selectedDate: $selectedDate)
                            .frame(width: geometry.size.width)
                    }
                }
                // apply visual offset when the user drags the view
                .offset(x: -geometry.size.width + dragOffset)
                // .gesture(DragGesture()) -> attaches a drag gesture recognizer to the view
                .gesture(
                    DragGesture()
                    // Called when the drag gesture changes (aka the user is dragging) -> update dragOffset with the horizontal drag distance (value.translation.width) to move the content
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                    // Called when the user finishes their drag -> depending on how far the user dragged the view, we go to the previous week, the next week or stay at the current week (threshold is at 1/3 of the screen)
                        .onEnded { value in
                            let threshold: CGFloat = geometry.size.width / 3
                            
                            if value.translation.width < -threshold {
                                // When swiped left more than threshold → next week
                                withAnimation(.easeInOut) {
                                    dragOffset = -geometry.size.width
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    displayedMonth = Calendar.current.date(byAdding: .month, value: 1, to: displayedMonth)!
                                    dragOffset = 0
                                }
                            } else if value.translation.width > threshold {
                                // When swiped right more than threshold → previous week
                                withAnimation(.easeInOut) {
                                    dragOffset = geometry.size.width
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    displayedMonth = Calendar.current.date(byAdding: .month, value: -1, to: displayedMonth)!
                                    dragOffset = 0
                                }
                            } else {
                                // Not far enough — snap back
                                withAnimation(.easeOut) {
                                    dragOffset = 0
                                }
                            }
                        }
                )
            }
            Divider().padding(.top, 20)
            
            ScrollView {
                CalendarItemListSubview(selectedDate: selectedDate)
            }
        }
        .padding(10)
    }
    

}

#Preview {
    MonthlyCalendarView()
}
