//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct Typography{
    public var h1: Font
    public var h2: Font
    public var h3: Font
    public var h4: Font
    public var h5: Font
    public var h6: Font
    public var body1: Font
    public var body2: Font
    public var body3: Font
    
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
    
    public func body1Style(color: Color = Color("Secondary")) -> some ViewModifier {
        return Body1Text(defaultTextColor: color)
    }

    public func h6Style(color: Color = Color("OnSurface")) -> some ViewModifier {
        return H6Style(defaultTextColor: color)
    }
    public func h5Style(color: Color = Color("OnSurface"))-> some ViewModifier {
        return H5Style(defaultTextColor: color)
    }
    public func h4Style(color: Color = Color("OnSurface")) -> some ViewModifier {
        return H4Style(defaultTextColor: color)
    }
    public func h3Style(color: Color = Color("OnSurface"))-> some ViewModifier {
        return H3Style(defaultTextColor: color)
    }
    public func h2Style(color: Color = Color("OnSurface")) -> some ViewModifier {
        return H2Style(defaultTextColor: color)
    }
    public  func h1Style(color: Color = Color("Primary")) -> some ViewModifier {
        return H1Style(defaultTextColor: color)
    }

    
}
