//
//  Life_ManagerApp.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

@main
struct Life_ManagerApp: App {
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView2()
                .environmentObject(viewModel)
        }
    }
}
