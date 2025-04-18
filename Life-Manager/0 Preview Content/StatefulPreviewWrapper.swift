//
//  StatefulPreviewWrapper.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 14.04.25.
//

import SwiftUI

// This is needed to simulate a binding in the preview of TaskDetailView
struct StatefulPreviewWrapper<Value>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> AnyView

    init(_ value: Value, @ViewBuilder content: @escaping (Binding<Value>) -> some View) {
        _value = State(initialValue: value)
        self.content = { binding in AnyView(content(binding)) }
    }

    var body: some View {
        content($value)
    }
}
