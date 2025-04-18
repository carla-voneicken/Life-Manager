import SwiftUI
struct ToDo: Identifiable {
    let id = UUID()
    var name: String
}
class Mission: Identifiable, ObservableObject, Equatable { // Wichtig um zu erkennen wo welcher String hingeschrieben wird. Ob lhs und rhs gleich sind oder nicht
    let id = UUID()
    @Published var name: String
    @Published var items: [ToDo] = []
    
    init(name: String) {
        self.name = name
    }
    
    // Equatable-Konformität - vergleicht die verschiedenen Id´s
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.id == rhs.id
    }
}
struct ToDoView: View {
    @State private var newMissionTitle: String = ""
    @State private var missions: [Mission] = [
        Mission(name: "Haushalt"),
        Mission(name: "Sport"),
        Mission(name: "Urlaub"),
        Mission(name: "Kinder")
    ]
    @State private var selectedMission: Mission?
    
//  Hintergrundfarbe bei Auswahl
    private func backgroundColor(for mission: Mission) -> Color {
        if let selected = selectedMission {
            return selected == mission ? Color.green.opacity(0.5) : Color.blue.opacity(0.2)
        } else {
// Wenn selectedMission nil ist, gib eine Standardfarbe zurück.
            return Color.blue.opacity(0.2)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    TextField("Neue Mission", text: $newMissionTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.green)
                        .padding()
                        .onTapGesture {
                            addNewMission()
                        }
                }
                .padding(.trailing, 10)


                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(missions) { mission in
                            Button {
                                selectedMission = mission
                            } label: {
                                Text(mission.name)
                                    .frame(width: 100, height: 30)
                                    .background(backgroundColor(for: mission))
                                    .border(Color.blue, width: 0)
                                    .cornerRadius(20)
                            }
                        }
                        
                    }
                }
                if let selectedMission = selectedMission {
                    MissionDetailView(mission: selectedMission)
                } else {
                  
                }
                Spacer()
            }
            .navigationTitle("To-Do Liste")
        }
    }
    func addNewMission() {
        if !newMissionTitle.isEmpty {
            let newMission = Mission(name: newMissionTitle)
            missions.append(newMission)
            newMissionTitle = ""
        }
    }
}
struct MissionDetailView: View {
    @ObservedObject var mission: Mission
    @State private var newToDoName = ""
    @State private var struckThroughToDo2 = Set<UUID>()
    
    var body: some View {
        VStack {
            Text("Artikel für \(mission.name)")
                .font(.title)
                .padding()
            HStack {
                TextField("Neues ToDo", text: $newToDoName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !newToDoName.isEmpty {
                        mission.items.append(ToDo(name: newToDoName))
                        newToDoName = ""
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(newToDoName.isEmpty)
            }
            .padding()
            List {
                ForEach(mission.items) { item in
                    HStack {
                        Text(item.name)
                            .strikethrough(struckThroughToDo2.contains(item.id), color: .red)
                            .onTapGesture {
                                if struckThroughToDo2.contains(item.id) {
                                    struckThroughToDo2.remove(item.id)
                                } else {
                                    struckThroughToDo2.insert(item.id)
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
#Preview {
    ToDoView()
}
