//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

/**
 A struct defining different corner radii for shapes.
 */
public struct Shapes {
    /// The corner radius for large shapes.
    public var largeCornerRadius: CGFloat
    
    /// The corner radius for medium-sized shapes.
    public var mediumCornerRadius: CGFloat
    
    /// The corner radius for small shapes.
    public var smallCornerRadius: CGFloat
    
    /**
     Initializes the Shapes struct with different corner radii.
     
     - Parameters:
        - largeCornerRadius: The corner radius for large shapes.
        - mediumCornerRadius: The corner radius for medium-sized shapes.
        - smallCornerRadius: The corner radius for small shapes.
     */
    public init(largeCornerRadius: CGFloat, mediumCornerRadius: CGFloat, smallCornerRadius: CGFloat) {
        self.largeCornerRadius = largeCornerRadius
        self.mediumCornerRadius = mediumCornerRadius
        self.smallCornerRadius = smallCornerRadius
    }
}
