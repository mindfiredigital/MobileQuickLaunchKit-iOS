//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)

public struct MQLColors {
    public var primary: Color
    public var secondary: Color
    public var tertiary: Color
    public var buttonTextPrimary: Color
    public var buttonTextSecondary: Color
    public var placeholderText: Color
    public var backGroundPrimary: Color
    public var backGroundSecondary: Color
    public var error: Color
    public var warning: Color
    public var success: Color
    public var defaultColor: Color
    public var borderColor: Color
    
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
