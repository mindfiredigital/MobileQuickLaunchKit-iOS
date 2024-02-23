//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct LargeTitleStyle: ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color?
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    func body(content: Content) -> some View {
        content.font(theme.typography.h2).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}


@available(iOS 13.0, *)
struct Body1Text :  ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color? = Color("Secondary")
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.body1).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}



@available(iOS 13.0, *)
struct H6Style :  ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color? = Color("OnSurface")
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h6).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}
@available(iOS 13.0, *)
struct H5Style :  ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color? = Color("OnSurface")
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h5).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}
@available(iOS 13.0, *)
struct H4Style :  ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color? = Color("OnSurface")
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h4).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}
@available(iOS 13.0, *)
struct H3Style :  ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color? = Color("OnSurface")
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h3).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}
@available(iOS 13.0, *)
struct H2Style : ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color? = Color("OnSurface")
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h2).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}
@available(iOS 13.0, *)
struct H1Style : ViewModifier {
    @EnvironmentObject var theme: Theme
    var defaultTextColor : Color?
    
    init(defaultTextColor: Color? = nil) {
        self.defaultTextColor = defaultTextColor
    }
    
    func body(content: Content) -> some View {
        
        return content.font(theme.typography.h1).foregroundColor(defaultTextColor ?? theme.colors.defaultColor).multilineTextAlignment(.leading)
    }
}

