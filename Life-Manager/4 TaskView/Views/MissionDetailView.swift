import SwiftUI
struct MissionDetailView: View {
    @ObservedObject var mission: Mission
    @State private var newTaskName = ""
    @State private var struckThroughTask2 = Set<UUID>()
    var body: some View {
        let startColor = Color("BackgroundColor")
        let endColor = Color("SeColor")
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
                        Image(systemName: struckThroughTask2.contains(item.id) ? "checkmark.square" : "square")
                            .onTapGesture {
                                if struckThroughTask2.contains(item.id) {
                                    struckThroughTask2.remove(item.id)
                                } else {
                                    struckThroughTask2.insert(item.id)
                                }
                            }
                        Text(item.name)
                            .foregroundColor(struckThroughTask2.contains(item.id) ? .gray : .black) // Korrigierte Zeile
                            .strikethrough(struckThroughTask2.contains(item.id), color: .red)
                    }
                }
                .onDelete { indexSet in
                    mission.items.remove(atOffsets: indexSet)
                }
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .edgesIgnoringSafeArea(.all)
    }
}
