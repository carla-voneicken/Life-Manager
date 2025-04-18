//
//  CalendarItemView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct CalendarItemView: View {
    let item: CalendarItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                if item.description != nil {
                    Text(item.description!)
                        .font(.caption2)
                }
                Spacer()
                if item.location != nil {
                    Text(item.location!)
                        .font(.caption)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(item.time)
                    .font(.subheadline)
                HStack(spacing: -10) {
                    ForEach(item.participants) { item in
                        let firstLetter = item.name.prefix(1).lowercased()
                        Image(systemName: "\(firstLetter).circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(item.color)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 80)
    }
}

#Preview {
    CalendarItemView(
        item:
            CalendarItem(
                title: "Zahnarzt",
                description: "Prophylaxe",
                time: "09:00 - 10:00",
                location: "Praxis Zeit für schöne Zähne",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[2]]
            )
    )
}
