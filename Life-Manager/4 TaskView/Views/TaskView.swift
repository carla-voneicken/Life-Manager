
// TaskView.swift
import SwiftUI
struct TaskView: View {
    @State private var newMissionColor: Color = Color.randomColor()
    @State private var newMissionTitle: String = ""
    @State private var missions: [Mission] = [
        Mission(name: "Sport", color: .red),
        Mission(name: "Urlaub", color: .yellow),
        Mission(name: "Wichtiges", color: .purple)
    ]
    @State private var selectedMission: Mission?
    @State private var showPopup: Bool = false
    var body: some View {
        let startColor = Color("BackgroundColor")
        let endColor = Color("SeColor")
        NavigationStack {
            VStack {
                HeaderView(showPopup: $showPopup)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(missions) { mission in
                            GenericButtonDetailView(data: mission, selectedData: $selectedMission)
                        }
                    }
                }
                if let selectedMission = selectedMission {
                    MissionDetailView(mission: selectedMission)
                }
                Spacer()
            }


            .overlay(
                Group {
                    if showPopup {
                        GenericPopupView(showPopup: $showPopup, titleText: $newMissionTitle, textFieldText: $newMissionTitle, confirmAction: addNewMission, cancelAction: { showPopup = false }, popupTitle: "Neue Mission hinzufügen", textFieldPlaceholder: "")
                            .transition(.scale)
                    }
                       
                }
                
            )
            .background {
                LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    func addNewMission() {
        if !newMissionTitle.isEmpty {
            let newMission = Mission(name: newMissionTitle)
            missions.append(newMission)
            newMissionTitle = ""
            newMissionColor = Color.randomColor()
        }
        showPopup = false
    }
}

#Preview {
    TaskView()
}
