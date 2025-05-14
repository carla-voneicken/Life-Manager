//
//  TodayView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI
import Foundation

struct TodayView: View {
    // Date and Formatter for displaying the current date
    let date: Date = Date()
    let calendar = Calendar.current
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    // Arrays of calendar and task items
    @State private var calendarItems = CalendarItem.samples
    @State private var taskItemsToday = TaskItem.samples
    
    // Selected calendar/task item (needed for displaying the modal sheet)
    @State private var selectedCalendarItem: CalendarItem? = nil
    @State private var selectedTaskItem: TaskItem? = nil
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    // Title "Termine"
                    Text("Termine")
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    // MARK: Calendar entries
                    LazyVStack(spacing: 0) {
                        ForEach(calendarItems.filter { Calendar.current.isDate($0.startDate, inSameDayAs: Date()) }, id: \.id) { item in
                            CalendarItemView(item: item)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0 , y: 2)
                                    )
                                .padding(.vertical, 4)
                                .onTapGesture {
                                    selectedCalendarItem = item
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Title "Aufgaben" and Add-Button
                    HStack {
                        Text("Aufgaben")
                            .font(.title)
                            .padding(.horizontal)
                            .padding(.top)
                        Spacer()
                        Button {
                            // TODO: Add a task
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.horizontal)
                                .foregroundColor(.black)
                                .font(.title)
                        }
                    }
                    
                    // MARK: Tasks
                    LazyVStack {
                        ForEach($taskItemsToday, id: \.id) { $item in
                            TaskItemView(item: $item)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0 , y: 2)
                                    )
                                .onTapGesture {
                                    selectedTaskItem = item
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Heute, \(formattedDate)")
            .toolbar {
                // Link to profile/settings
                NavigationLink(destination: ProfileView()) {
                    Image("profilepicture")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .tint(.green)
                        .clipShape(Circle())
                }
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
                    CalendarItemDetailView(item: $calendarItems[index])
                        // Make the sheet oben to 40% of the screen
                        .presentationDetents([.fraction(0.4)])
                }
            }
            // MARK: Modal sheet for task items
            .sheet(isPresented: Binding<Bool>(
                get: { selectedTaskItem != nil },
                set: { if !$0 { selectedTaskItem = nil } }
            )) {
                if let selected = selectedTaskItem,
                   let index = taskItemsToday.firstIndex(where: { $0.id == selected.id }) {
                    TaskDetailView(item: $taskItemsToday[index])
                        .presentationDetents([.fraction(0.25)])
                }
            }
        }
    }
}


#Preview {
    TodayView()
}
