//
//  EnvironmentKey.swift
//  Life-Manager
//
//  Created by Christiane Roth on 18.04.25.
//

import SwiftUI

private struct AppColorKey : EnvironmentKey {
    static let defaultValue = AppColors()
}
extension EnvironmentValues {
    var appColors: AppColors {
        get {self[AppColorKey.self]}
        set {self[AppColorKey.self] = newValue}
    }
}
extension View {
            func setAppColors(colors: AppColors) -> some View {
                self.environment (\.appColors, colors)
                
            }
        }

    

