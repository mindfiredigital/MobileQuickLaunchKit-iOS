//
//  File.swift
//
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

/**
 The custom color class includes all the necessary color properties that may be required in an app.
 */
@available(iOS 13.0, *)
public struct MQLColors {
    /// The primary color.
    public var primary: Color
    
    /// The secondary color.
    public var secondary: Color
    
    /// The tertiary color.
    public var tertiary: Color
    
    /// The color for primary button text.
    public var buttonTextPrimary: Color
    
    /// The color for secondary button text.
    public var buttonTextSecondary: Color
    
    /// The color for placeholder text.
    public var placeholderText: Color
    
    /// The primary background color.
    public var backGroundPrimary: Color
    
    /// The secondary background color.
    public var backGroundSecondary: Color
    
    /// The error color.
    public var error: Color
    
    /// The warning color.
    public var warning: Color
    
    /// The success color.
    public var success: Color
    
    /// The default color.
    public var defaultColor: Color
    
    /// The border color.
    public var borderColor: Color
    
    /**
     Initializes the MQLColors struct with custom color properties.
     
     - Parameters:
        - primary: The primary color.
        - secondary: The secondary color.
        - tertiary: The tertiary color.
        - buttonTextPrimary: The color for primary button text.
        - buttonTextSecondary: The color for secondary button text.
        - placeholderText: The color for placeholder text.
        - backGroundPrimary: The primary background color.
        - backGroundSecondary: The secondary background color.
        - error: The error color.
        - warning: The warning color.
        - success: The success color.
        - defaultColor: The default color.
        - borderColor: The border color.
     */
    public init(primary: Color, secondary: Color, tertiary: Color, buttonTextPrimary: Color, buttonTextSecondary: Color, placeholderText: Color, backGroundPrimary: Color, backGroundSecondary: Color, error: Color, warning: Color, success: Color, defaultColor: Color, borderColor: Color) {
        self.primary = primary
        self.secondary = secondary
        self.tertiary = tertiary
        self.buttonTextPrimary = buttonTextPrimary
        self.buttonTextSecondary = buttonTextSecondary
        self.placeholderText = placeholderText
        self.backGroundPrimary = backGroundPrimary
        self.backGroundSecondary = backGroundSecondary
        self.error = error
        self.warning = warning
        self.success = success
        self.defaultColor = defaultColor
        self.borderColor = borderColor
    }
}
