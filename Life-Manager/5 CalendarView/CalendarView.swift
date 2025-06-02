//
//  CalendarView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 15.05.25.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        HStack {
            VStack {
                DropDownMenu1()
            }
        }
    }
}

#Preview {
    CalendarView()
}


struct DropDownMenu: View {
    var calendarLayouts = ["Wochenansicht", "Monatsansicht"]
    @State private var selectedLayout: String = "Monatsansicht"

    var body: some View {
        VStack {
            Menu(selectedLayout) {
                ForEach(calendarLayouts, id: \.self) { layout in
                    Button(layout, action: {
                        selectedLayout = layout
                    })
                }
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(UIColor.lightGray).opacity(0.4))

    }
}

struct DropDownMenu1: View {
    var calendarLayouts = ["Wochenansicht", "Monatsansicht"]
    @State private var selectedLayout: String = "Monatsansicht"

    var body: some View {
        VStack {
            Picker("fruits", selection: $selectedLayout) {
                ForEach(calendarLayouts, id: \.self) { layout in
                    Text(layout)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(UIColor.lightGray).opacity(0.4))

    }
}

