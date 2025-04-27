import SwiftUI
struct MissionButtonView: View {
    let mission: Mission
    
    
    // Binding, damit Änderungen hier die Hauptansicht beeinflussen.
    @Binding var selectedMission: Mission?
    
    
    var body: some View {
        Button {
            selectedMission = mission
        } label: {
            Text(mission.name)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 150, height: 150)
                .background(mission.color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5) 
                .padding(10)
        }
    }
}
struct MissionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        // Erstelle eine Beispielmission mit einer Farbe
        let exampleMission = Mission(name: "Test Mission")
        exampleMission.color = .orange
        return MissionButtonView(mission: exampleMission, selectedMission: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
