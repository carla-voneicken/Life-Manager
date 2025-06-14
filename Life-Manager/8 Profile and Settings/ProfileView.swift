//
//  ProfileView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 09.04.25.
//

import SwiftUI

struct ProfileView: View {
    let startColor = Color("BackgroundColor")
    let endColor = Color("SeColor")
    var body: some View {
        Text("See your profile information and settings here")
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Füge diesen Frame hinzu
                 .background {
                     LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                         .edgesIgnoringSafeArea(.all)
                 }
    }
}

#Preview {
    ProfileView()
}
