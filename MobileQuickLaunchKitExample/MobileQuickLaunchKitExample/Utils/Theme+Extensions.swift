//
//  Theme+Extensions.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 18/01/24.
//
import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

// MARK: - Extension for defining predefined themes.
@available(iOS 13.0, *)
extension Theme {
    
    // These colors are defined in color assets
    static let appTheme = Theme(
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

    // These colors are defined in color assets
    static let theme1 = Theme(
        colors: MQLColors(
            primary: Color("Theme1Primary"),
            secondary: Color("Theme1Secondary"),
            tertiary: Color("Theme1Tertiary"),
            buttonTextPrimary: Color("Theme1ButtonTextPrimary"),
            buttonTextSecondary: Color("Theme1ButtonTextSecondary"),
            placeholderText: Color("Theme1PlaceholderText"),
            backGroundPrimary: Color("Theme1BackgroundPrimary"),
            backGroundSecondary: Color("Theme1BackgroundSecondary"),
            error: Color("Error"),
            warning: Color("Warning"),
            success: Color("Success"),
            defaultColor: Color("Default"),
            borderColor: Color("BorderColor")
        ),
        typography: Typography(
            h1: Font.custom("Georgia-Bold", size: 30),
            h2: Font.custom("Georgia-Bold", size: 24),
            h3: Font.custom("Georgia-Bold", size: 18),
            h4: Font.custom("Georgia-Bold", size: 14),
            h5: Font.custom("Georgia-Bold", size: 12),
            h6: Font.custom("Georgia-Bold", size: 10),
            body1: Font.custom("Georgia-Regular", size: 15),
            body2: Font.custom("Georgia-Regular", size: 14),
            body3: Font.custom("Georgia-Regular", size: 12)
        )
    )
    
    // These colors are defined in color assets
    static let theme2 = Theme(
        colors: MQLColors(
            primary: Color("Theme2Primary"),
            secondary: Color("Theme2Secondary"),
            tertiary: Color("Theme2Tertiary"),
            buttonTextPrimary: Color("ButtonTextPrimary"),
            buttonTextSecondary: Color("ButtonTextSecondary"),
            placeholderText: Color("PlaceholderText"),
            backGroundPrimary: Color("BackgroundPrimary"),
            backGroundSecondary: Color("BackgroundSecondary"),
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
            body3: Font.custom("ArialMT", size: 12)
        )
    )
    
    // These colors are defined in color assets
    static let theme3 = Theme(
        colors: MQLColors(
            primary: Color("Theme3Primary"),
            secondary: Color("Theme3Secondary"),
            tertiary: Color("Theme3Tertiary"),
            buttonTextPrimary: Color("ButtonTextPrimary"),
            buttonTextSecondary: Color("ButtonTextSecondary"),
            placeholderText: Color("PlaceholderText"),
            backGroundPrimary: Color("Theme3BackgroundPrimary"),
            backGroundSecondary: Color("Theme3BackgroundSecondary"),
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
            body3: Font.custom("ArialMT", size: 12)
        )
    )
}
