//
//  TodayView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct TodayView: View {
    
    @State private var calendarItemsToday = CalendarItem.samples
    @State private var taskItemsToday = TaskItem.samples
    
    @State private var selectedCalendarItem: CalendarItem? = nil
    @State private var selectedTaskItem: TaskItem? = nil
    
    let date: Date = Date()
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        Text("Termine")
                            .font(.title)
                            .padding(.horizontal)
                            .padding(.top)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.horizontal)
                                .foregroundColor(.black)
                                .font(.title)
                        }
                    }
                    
                    LazyVStack(spacing: 0) {
                        ForEach(calendarItemsToday, id: \.id) { item in
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
                    
                    HStack {
                        Text("Aufgaben")
                            .font(.title)
                            .padding(.horizontal)
                            .padding(.top)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus.circle")
                                .padding(.horizontal)
                                .foregroundColor(.black)
                                .font(.title)
                        }
                    }
                    
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
                
//                Button {
//                    print("About tapped!")
//                } label: {
//                    Image(systemName: "plus")
//                        .resizable()
//                        .frame(width: 30, height: 25)
//                        .tint(.black)
//                }
                
                NavigationLink(destination: ProfileView()) {
                    Image("profilepicture")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .tint(.green)
                        .clipShape(Circle())
                }
            }
            .sheet(item: $selectedCalendarItem) { item in
                CalendarDetailView(item: item)
                    .presentationDetents([.fraction(0.3)])
            }
            
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
