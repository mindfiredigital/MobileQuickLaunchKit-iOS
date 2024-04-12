//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

/**
 A button modifier that selects its color and font from the theme object.
 */
struct ButtonModifier: ViewModifier {
    
    @EnvironmentObject var theme: Theme
    
    /**
     Modifies the appearance of the view.
     
     - Parameter content: The content of the view.
     - Returns: A modified view.
     */
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(theme.colors.buttonTextPrimary)
            .frame(height: 50)
            .background(RoundedRectangle(cornerRadius: 8).fill(theme.colors.primary))
            .font(theme.typography.h4)
    }
}


extension View {
    /**
     Creates a button that matches the theme seamlessly.
     
     - Returns: A modified view.
     */
    public func themeButtonModifier() -> some View {
        self.modifier(ButtonModifier())
    }
}
