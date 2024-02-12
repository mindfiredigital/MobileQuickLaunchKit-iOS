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
