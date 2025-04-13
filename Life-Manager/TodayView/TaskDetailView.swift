//
//  TaskDetailView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct TaskDetailView: View {
    var item: TaskItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.largeTitle)
                .bold()
            
            if let description = item.description {
                Text(description)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

#Preview {
    TaskDetailView(item: TaskItem(
        title: "Einkaufen",
        description: "Pfand nicht vergessen",
        isCompleted: false
    ))
}
