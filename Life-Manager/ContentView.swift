//
//  ContentView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "fireworks")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundStyle(.tint)
                .padding()
            Text("Welcome to Life Manager")
                .font(.title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
