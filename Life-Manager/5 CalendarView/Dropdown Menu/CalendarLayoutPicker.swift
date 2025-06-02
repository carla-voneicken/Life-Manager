////
////  CalendarLayoutPicker.swift
////  Life-Manager
////
////  Created by Carla von Eicken on 02.06.25.
////
//
//import SwiftUI
//
//struct CalendarLayoutPicker: View {
//    @Binding var selectedLayout: CalendarLayout
//    // the symbol we'll show in the dropdown button?
//    var icon: String {
//        if selectedLayout == .month { "CalendarIcon30" }
//        else if selectedLayout == .week { "CalendarIcon7" }
//        else { "CalendarIcon1" }
//    }
//    
//    // controls wether the dropdown menu is opened or closed
//    @State var isExpanded = false
//    // stores the width of the dropdown button so that we can align the menu properly with it
//    @State var menuWidth: CGFloat = 0
//
//    // control if option icon should be shown or not
//    var showIcon: Bool = true
//        
//    // menu options
//    let dropdownOptions = [
//        DropdownOption(title: "Monatsansicht", icon: "CalendarIcon1", action: { print("Show daily view") }),
//        DropdownOption(title: "Wochenansicht", icon: "CalendarIcon7", action: { print("Show weekly view") }),
//        DropdownOption(title: "Tagesansicht", icon: "CalendarIcon30", action: { print("Show monthly view") })
//    ]
//    
//    var body: some View {
//        ZStack {
//            Button(action: {
//                isExpanded.toggle()
//            }) {
//                // button with icon and a circular background with a soft shadow
//                Image(icon)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 25, height: 25) // icon size
//                    .padding(10)
//                    .background(.gray.opacity(0.3), in: .circle)
//                    .frame(width: 40, height: 40) // overall circle size
//                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
//            }
//            .tint(.primary).frame(height: 50)
//            .frame(width: menuWidth, alignment: .trailing)
//            
//            // attaching the dropdown menu as an overlay
//            .overlay(alignment: .top) {
//                // if isExpanded is true we're displaying a VStack of menu options
//                if isExpanded {
//                    VStack(alignment: .leading, spacing: 8) {
//                        ForEach(options) { option in
//                            HStack(spacing: 8) {
//                                // if showIcon is true and there is an icon, it is shown, otherwise we're just showing the option text
//                                if showIcon {
//                                    Image(option.icon)
//                                        .resizable()
//                                        .frame(width: 20, height: 20)
//                                    }
//                                Text(option.title)
//                            }
//                            .foregroundColor(option.color)
//                            .padding(.vertical, 5)
//                            
//                            // each option has an onTapGesture, when tapping the item, it runs the action attached to it and then closes the menu
//                            .onTapGesture {
//                                option.action()
//                                withAnimation {
//                                    isExpanded = false
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                    
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.white)
//                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
//                    )
//                    // offset gives the dropdown menu a bit of space from the button
//                    .offset(y: 50)
//                    // make sure the menu takes as much space as it needs and doesn't get compressed
//                    .fixedSize()
//                    // makes the menu appear and disappear smoothly
//                    .transition(
//                        .scale(scale: 0, anchor: .topTrailing)
//                        .combined(with: .opacity)
//                        .combined(with: .offset(y: 40))
//                    )
//                    // measure the actual width of the dropdown menu once it appears
//                    .background(
//                        GeometryReader { proxy in
//                            Color.clear // so it doesn't effect the layout visually
//                                // onAppear we store the width in our menuWidth variable
//                                .onAppear {
//                                    menuWidth = proxy.size.width
//                                }
//                        }
//                    )
//                }
//            }
//        }
//    }
//}
//
//
//
//
////#Preview {
////    CalendarLayoutPicker()
////}
