//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

/**
 A struct defining different spacing values.
 */
public struct Spacing {
    /// The spacing value for large spaces.
    public var largeSpacing: CGFloat
    
    /// The spacing value for medium spaces.
    public var mediumSpacing: CGFloat
    
    /// The spacing value for small spaces.
    public var smallSpacing: CGFloat
    
    /// The spacing value for extra large spaces.
    public var extraLargeSpacing: CGFloat
    
    /**
     Initializes the Spacing struct with different spacing values.
     
     - Parameters:
        - largeSpacing: The spacing value for large spaces.
        - mediumSpacing: The spacing value for medium spaces.
        - smallSpacing: The spacing value for small spaces.
        - extraLargeSpacing: The spacing value for extra large spaces.
     */
    public init(largeSpacing: CGFloat, mediumSpacing: CGFloat, smallSpacing: CGFloat, extraLargeSpacing: CGFloat) {
        self.largeSpacing = largeSpacing
        self.mediumSpacing = mediumSpacing
        self.smallSpacing = smallSpacing
        self.extraLargeSpacing = extraLargeSpacing
    }
}
