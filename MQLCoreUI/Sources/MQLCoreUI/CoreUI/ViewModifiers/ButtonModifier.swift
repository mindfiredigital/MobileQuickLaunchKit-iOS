//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

struct ButtonModifier: ViewModifier {
    
    @EnvironmentObject var theme: Theme
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(theme.colors.buttonTextPrimary)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 15).fill(theme.colors.primary))
            .font(theme.typography.h4)
    }
}


extension View {
    public func themeButtonModifier() -> some View {
        self.modifier(ButtonModifier())
    }
}
