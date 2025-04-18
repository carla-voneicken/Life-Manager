//
//  StartTab.swift
//  Life-Manager
//
//  Created by Christiane Roth on 13.04.25.
//

import SwiftUI

struct StartTab: View {
    @State private var router = Router()
    var body: some View {
        TabView(selection: $router.selectedTab) {
            ForEach(TabViewEnum.allCases) { tab in
                let tabItem = tab.tabItem
            
            Tab(
                tabItem.name,
                systemImage: tabItem.systemImage,
                value: tab) {
                    tab
                }
        }
    }
        .environment(router)
}
}
#Preview {
    StartTab()
}

@Observable
class Router {
    var selectedTab: TabViewEnum = .todayView
}

