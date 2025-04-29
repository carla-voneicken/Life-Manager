//
//  ShoppingButtonDetailView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 29.04.25.
//

import SwiftUI
struct SupermarketButtonView: View {
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
        
        @State var selectedMission: Mission? = nil
        
        return MissionButtonView(mission: exampleMission, selectedMission: $selectedMission)
            .previewLayout(.sizeThatFits)
    }
}

//sucht sich die Farbe zufällig raus zwischen 0 und 1 und erstellt die Farbe
extension Color {
    static func random() -> Color {
        return Color(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1)
        )
    }
}

