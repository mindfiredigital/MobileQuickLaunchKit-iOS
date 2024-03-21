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
}
