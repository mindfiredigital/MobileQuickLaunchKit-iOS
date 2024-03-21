//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

/**
 A class designed to centrally manage fonts across the entire application.
 */
@available(iOS 13.0, *)
public struct Typography{
    /// The font for heading level 1.
    public var h1: Font
    
    /// The font for heading level 2.
    public var h2: Font
    
    /// The font for heading level 3.
    public var h3: Font
    
    /// The font for heading level 4.
    public var h4: Font
    
    /// The font for heading level 5.
    public var h5: Font
    
    /// The font for heading level 6.
    public var h6: Font
    
    /// The font for body text level 1.
    public var body1: Font
    
    /// The font for body text level 2.
    public var body2: Font
    
    /// The font for body text level 3.
    public var body3: Font
    
    /**
     Initializes the Typography with font properties.
     
     - Parameters:
     - h1: The font for heading level 1.
     - h2: The font for heading level 2.
     - h3: The font for heading level 3.
     - h4: The font for heading level 4.
     - h5: The font for heading level 5.
     - h6: The font for heading level 6.
     - body1: The font for body text level 1.
     - body2: The font for body text level 2.
     - body3: The font for body text level 3.
     */
    public init(h1: Font, h2: Font, h3: Font, h4: Font, h5: Font, h6: Font, body1: Font, body2: Font, body3: Font) {
        self.h1 = h1
        self.h2 = h2
        self.h3 = h3
        self.h4 = h4
        self.h5 = h5
        self.h6 = h6
        self.body1 = body1
        self.body2 = body2
        self.body3 = body3
    }
    
    /**
     Returns a view modifier for applying Body1Text style to a view.
     
     - Parameter color: The color of the text. Default is the secondary color.
     - Returns: A view modifier.
     */
    public func body1Style(color: Color = Color("Secondary")) -> some ViewModifier {
        return Body1Text(defaultTextColor: color)
    }
    
    /**
     Returns a view modifier for applying H6Style to a view.
     
     - Parameter color: The color of the text. Default is the onSurface color.
     - Returns: A view modifier.
     */
    public func h6Style(color: Color = Color("OnSurface")) -> some ViewModifier {
        return H6Style(defaultTextColor: color)
    }
    
    /**
     Returns a view modifier for applying H5Style to a view.
     
     - Parameter color: The color of the text. Default is the onSurface color.
     - Returns: A view modifier.
     */
    public func h5Style(color: Color = Color("OnSurface"))-> some ViewModifier {
        return H5Style(defaultTextColor: color)
    }
    
    /**
     Returns a view modifier for applying H4Style to a view.
     
     - Parameter color: The color of the text. Default is the onSurface color.
     - Returns: A view modifier.
     */
    public func h4Style(color: Color = Color("OnSurface")) -> some ViewModifier {
        return H4Style(defaultTextColor: color)
    }
    
    /**
     Returns a view modifier for applying H3Style to a view.
     
     - Parameter color: The color of the text. Default is the onSurface color.
     - Returns: A view modifier.
     */
    public func h3Style(color: Color = Color("OnSurface"))-> some ViewModifier {
        return H3Style(defaultTextColor: color)
    }
    
    /**
     Returns a view modifier for applying H2Style to a view.
     
     - Parameter color: The color of the text. Default is the onSurface color.
     - Returns: A view modifier.
     */
    public func h2Style(color: Color = Color("OnSurface")) -> some ViewModifier {
        return H2Style(defaultTextColor: color)
    }
    
    /**
     Returns a view modifier for applying H1Style to a view.
     
     - Parameter color: The color of the text. Default is the primary color.
     - Returns: A view modifier.
     */
    public  func h1Style(color: Color = Color("Primary")) -> some ViewModifier {
        return H1Style(defaultTextColor: color)
    }
}
