//
//  TaskItemView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct TaskItemView: View {
    @Binding var item: TaskItem
    
    var body: some View {
        HStack {
            // Image of square (can be "checked")
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    item.isCompleted.toggle()
                }
                .padding(.trailing)
            VStack (alignment: .leading){
                // Title
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(item.isCompleted ? .gray : .black)
                    .strikethrough(item.isCompleted ? true : false)
                // Description
                if item.description != nil {
                    Text(item.description!)
                        .font(.caption2)
                        .foregroundColor(item.isCompleted ? .gray : .black)
                        .strikethrough(item.isCompleted ? true : false)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    @Previewable @State var item: TaskItem = TaskItem(
        title: "Einkaufen",
        description: "Pfand nicht vergessen",
        isCompleted: false
    )
    TaskItemView(item: $item)
}
