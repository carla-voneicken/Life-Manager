//
//  TaskItem.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import Foundation

struct TaskItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String?
    var isCompleted: Bool = false
    
    static var samples: [TaskItem] =
        [
            TaskItem(
                title: "Einkaufen",
                description: "Pfand nicht vergessen",
                isCompleted: false
            ),
            TaskItem(
                title: "Wäsche",
                isCompleted: false
            ),
            TaskItem(
                title: "Arztpraxis anrufen",
                description: "Termin für Impfung ausmachen",
                isCompleted: false
            )
        ]
    }

