//
//  TaskDetailView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var item: TaskItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: Title
            TextField("Aufgabe", text: $item.title)
                        .font(.largeTitle)
                        .bold()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // MARK: Description
            // Creating a custom Binding<String> manually using get and set closures to work around the fact that item.description is optional (String?), but TextEditor needs a non-optional String
            TextEditor(text: Binding(
                // If item.description is nil, return an empty string ("") for the editor to display
                get: { item.description ?? "" },
                // If the user types something, set item.description = new text; if they delete everything, set item.description = nil
                set: { item.description = $0.isEmpty ? nil : $0 }
            ))
            .frame(height: 80)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
            .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    StatefulPreviewWrapper(TaskItem(
        title: "Einkaufen",
        description: "Pfand nicht vergessen",
        isCompleted: false
    )) { item in
        TaskDetailView(item: item)
    }
}
