
import SwiftUI


struct MissionDetailView: View {
    @ObservedObject var mission: Mission
    @State private var newTaskName = ""
    @State private var struckThroughTask2 = Set<UUID>()
    var body: some View {
        VStack {
            Text("Items for \(mission.name)")
                .font(.title)
                .padding()
            HStack {
                TextField("New Task", text: $newTaskName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !newTaskName.isEmpty {
                        mission.items.append(Task(name: newTaskName))
                        newTaskName = ""
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(newTaskName.isEmpty)
            }
            .padding()
            List {
                ForEach(mission.items) { item in
                    HStack {
                        Text(item.name)
                            .strikethrough(struckThroughTask2.contains(item.id), color: .red)
                            .onTapGesture {
                                if struckThroughTask2.contains(item.id) {
                                    struckThroughTask2.remove(item.id)
                                } else {
                                    struckThroughTask2.insert(item.id)
                                }
                            }
                    }
                }
                .onDelete { indexSet in
                    mission.items.remove(atOffsets: indexSet)
                }
            }
        }
    }
}
