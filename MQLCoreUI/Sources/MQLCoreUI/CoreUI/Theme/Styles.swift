//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

/**
 A ViewModifier to apply large title style to a view.
 */
@available(iOS 13.0, *)
struct LargeTitleStyle: ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor: Color?
    
    /**
     Initializes the LargeTitleStyle with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the large title style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with large title style.
     */
    func body(content: Content) -> some View {
        content.font(theme.typography.h2).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply body1 text style to a view.
 */
@available(iOS 13.0, *)
struct Body1Text:  ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor: Color? = Color("Secondary")
    
    /**
     Initializes the Body1Text with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the body1 text style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with body1 text style.
     */
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.body1).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply H6Style to a view.
 */
@available(iOS 13.0, *)
struct H6Style:  ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor : Color? = Color("OnSurface")
    
    /**
     Initializes the H6Style with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the H6Style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with H6Style.
     */
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h6).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply H5Style to a view.
 */
@available(iOS 13.0, *)
struct H5Style:  ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor : Color? = Color("OnSurface")
    
    /**
     Initializes the H5Style with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the H5Style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with H5Style.
     */
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h5).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply H4Style to a view.
 */
@available(iOS 13.0, *)
struct H4Style:  ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor : Color? = Color("OnSurface")
    
    /**
     Initializes the H4Style with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the H4Style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with H4Style.
     */
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h4).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply H3Style to a view.
 */
@available(iOS 13.0, *)
struct H3Style:  ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor : Color? = Color("OnSurface")
    
    /**
     Initializes the H3Style with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the H3Style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with H3Style.
     */
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h3).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply H2Style to a view.
 */
@available(iOS 13.0, *)
struct H2Style: ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor : Color? = Color("OnSurface")
    
    /**
     Initializes the H2Style with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the H2Style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with H2Style.
     */
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h2).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

/**
 A ViewModifier to apply H1Style to a view.
 */
@available(iOS 13.0, *)
struct H1Style: ViewModifier {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The default text color.
    var defaultTextColor : Color?
    
    /**
     Initializes the H1Style with an optional default text color.
     
     - Parameter defaultTextColor: An optional default text color.
     */
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    /**
     Applies the H1Style to the content.
     
     - Parameter content: The content view.
     - Returns: The modified content view with H1Style.
     */
    func body(content: Content) -> some View {
        return content.font(theme.typography.h1).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

