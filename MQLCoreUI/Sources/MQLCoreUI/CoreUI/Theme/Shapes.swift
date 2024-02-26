//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

public struct Shapes {
    public var largeCornerRadius: CGFloat
    public var mediumCornerRadius: CGFloat
    public var smallCornerRadius: CGFloat
    
    public init(largeCornerRadius: CGFloat, mediumCornerRadius: CGFloat, smallCornerRadius: CGFloat) {
        self.largeCornerRadius = largeCornerRadius
        self.mediumCornerRadius = mediumCornerRadius
        self.smallCornerRadius = smallCornerRadius
    }
}
