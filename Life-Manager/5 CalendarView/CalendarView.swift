//
//  CalendarView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 07.04.25.
//

import SwiftUI

struct CalendarView: View {
    let startColor = Color("BackgroundColor")
    let endColor = Color("SeColor")
    var body: some View {
        Text("Here will be the Calendar View")
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Füge diesen Frame hinzu
                 .background {
                     LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                         .edgesIgnoringSafeArea(.all)
                 }
    }
}

#Preview {
    CalendarView()
}
