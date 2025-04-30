import SwiftUI

struct WeeklyCalendarView: View {
    
    @State private var currentDate: Date = Date()
    @State private var dragOffset: CGFloat = 0
    @State private var currentIndex: Int = 1 // Middle of 3 views
    
    let screenWidth = UIScreen.main.bounds.width
    
    
    
    var body: some View {
        HStack {
            WeekHeaderView(displayedWeek: $currentDate)
        }
        .tint(.primary)
        .padding()
        
        let dates = [
            Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!,
            currentDate,
            Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
        ]
        
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(dates, id: \.self) { date in
                    WeekSubview(displayedWeek: date)
                        .frame(width: geometry.size.width)
                }
            }
            .offset(x: -geometry.size.width + dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = geometry.size.width / 3
                        
                        if value.translation.width < -threshold {
                            // Swipe left → next week
                            withAnimation(.easeInOut) {
                                dragOffset = -geometry.size.width
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
                                dragOffset = 0
                            }
                        } else if value.translation.width > threshold {
                            // Swipe right → previous week
                            withAnimation(.easeInOut) {
                                dragOffset = geometry.size.width
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
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
    }
}

#Preview {
    WeeklyCalendarView()
}
