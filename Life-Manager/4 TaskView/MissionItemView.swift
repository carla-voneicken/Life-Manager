//
//  TaskItemView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 29.04.25.
//
import SwiftUI
struct MissionItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
struct MissionItemView: View {
    @Binding var item: MissionItem
    var body: some View {
        HStack {
            // Image of square (can be "checked")
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    item.isCompleted.toggle()
                }
                .padding(.trailing)
            VStack(alignment: .leading) {
                // Title
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(item.isCompleted ? .gray : .black)
                    .strikethrough(item.isCompleted ? true : false)
            }
        }
    }
}

struct MissionItemView_Previews: PreviewProvider {
    static var previews: some View {
        @State var exampleItem = MissionItem(title: "Mission Item", isCompleted: false)
        return MissionItemView(item: $exampleItem)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
