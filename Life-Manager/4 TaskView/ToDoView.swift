import SwiftUI

struct ToDo: Identifiable {
    let id = UUID()
    var name: String
}

class Mission: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    @Published var items: [ToDo] = []
    
    init(name: String) {
        self.name = name
    }
}
struct ToDoView: View {
    
    @State private var missions: [Mission] = [
        Mission(name: "Haushalt"),
        Mission(name: "Sport"),
        Mission(name: "Urlaub"),
        Mission(name: "Kinder")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(missions) { mission in
                            NavigationLink(destination: MissionDetailView(mission: mission)) {
                                Text(mission.name)
                                    .frame(width: 100, height: 30)
                                    .background(Color.blue.opacity(0.2))
                                    .border(Color.blue, width: 0)
                                    .cornerRadius(20)
                                    .padding()
                                    .padding(.top, 50)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 650)
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                    .padding()
                    .onTapGesture {
                        addNewMission()
                    }
            }
            .navigationTitle(Text("To-Do Liste"))
        }
    }
    
    private func addNewMission() {
        let newMission = Mission(name: "Neue Mission")
        missions.append(newMission)
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
       
        .navigationTitle(mission.name)
    }
}
#Preview {
    ToDoView()
}
