//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

public struct Spacing {
    public var largeSpacing: CGFloat
    public var mediumSpacing: CGFloat
    public var smallSpacing: CGFloat
    public var extraLargeSpacing: CGFloat
    
    public init(largeSpacing: CGFloat, mediumSpacing: CGFloat, smallSpacing: CGFloat, extraLargeSpacing: CGFloat) {
        self.largeSpacing = largeSpacing
        self.mediumSpacing = mediumSpacing
        self.smallSpacing = smallSpacing
        self.extraLargeSpacing = extraLargeSpacing
    }
}
