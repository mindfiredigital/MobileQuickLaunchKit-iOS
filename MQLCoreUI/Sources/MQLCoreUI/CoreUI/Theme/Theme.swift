//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

/**
 A class designed to centrally manage colors and fonts across the entire application.
 */
@available(iOS 13.0, *)
public class Theme: ObservableObject{
    /// The MQLColors object includes all the necessary color properties that may be required in an app.
    public let colors: MQLColors
    
    /// The Typography object includes all the necessary font properties that may be required in an app.
    public let typography: Typography
    
    /// selected color scheme
    @AppStorage("colorScheme") public var selectedColorScheme: String = "system"
    /**
     Initializes the Theme with colors and typography.
     
     - Parameters:
     - colors: The MQLColors object representing color properties.
     - typography: The Typography object representing font properties.
     */
    public init(colors: MQLColors, typography: Typography) {
        self.colors = colors
        self.typography = typography
    }
    
    /**
       Retrieves the preferred color scheme based on the selected color scheme.

       - Returns: A `ColorScheme` enum value representing the preferred color scheme, or `nil` if no valid color scheme is selected.

       - Note: The color schemes include `.light` and `.dark`.
    */
    public func getPreferredColorScheme() -> ColorScheme? {
        switch selectedColorScheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
}
