//
//  ContentView2.swift
//  Life-Manager
//
//  Created by Christiane Roth on 07.06.25.
//

import SwiftUI

struct ContentView2: View {
    @EnvironmentObject var ViewModel: AuthViewModel
    var body: some View {
        Group {
            if ViewModel.userSession != nil {
                ContentView()
            } else {
                VStack {
                    Text(ViewModel.newUserGreeting)
                    LoginView()
                }
            }
        }
    }
}
