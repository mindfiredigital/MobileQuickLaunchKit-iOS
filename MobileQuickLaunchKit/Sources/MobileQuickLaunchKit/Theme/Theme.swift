//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI


@available(iOS 13.0, *)
public class Theme : ObservableObject{
    public let colors: MQLColors
    public let typography: Typography
//    public let shapes: Shapes
//    public let spacing: Spacing
    
    public init(colors: MQLColors, typography: Typography) {
        self.colors = colors
        self.typography = typography
    }
    
}

@available(iOS 13.0, *)
extension Theme {
    
    // These colors are defined in color assets
    static let packageTheme = Theme(
        colors: MQLColors(
            primary: Color("ThemePrimary"),
            secondary: Color("ThemeSecondary"),
            tertiary: Color("ThemeTertiary"),
            buttonTextPrimary: Color("ButtonTextPrimary"),
            buttonTextSecondary: Color("ButtonTextSecondary"),
            placeholderText: Color("PlaceholderText"),
            backGroundPrimary: Color("ThemeBackgroundPrimary"),
            backGroundSecondary: Color("ThemeBackgroundSecondary"),
            error: Color("Error"),
            warning: Color("Warning"),
            success: Color("Success"),
            defaultColor: Color("Default"),
            borderColor: Color("BorderColor")
        ),
        typography: Typography(
            h1: Font.custom("Arial-BoldMT", size: 30), //Use for bold headers
            h2: Font.custom("Arial-BoldMT", size: 24),
            h3: Font.custom("Arial-BoldMT", size: 18),
            h4: Font.custom("Arial-BoldMT", size: 15), // Use for button text
            h5: Font.custom("Arial-BoldMT", size: 12),
            h6: Font.custom("Arial-BoldMT", size: 10),
            body1: Font.custom("ArialMT", size: 15), // Use for body text
            body2: Font.custom("ArialMT", size: 14),
            body3: Font.custom("ArialMT", size: 16)
        )
    )
}
