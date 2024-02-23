//
//  File.swift
//
//
//  Created by Satyam Tripathi on 13/12/23.
//

import Foundation
import SwiftUI

public struct ScreenSize {
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static var topSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    public static var bottomSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    public static func scaleWidth(_ value: CGFloat) -> CGFloat {
        return screenWidth * value
    }
    
    public static func scaleHeight(_ value: CGFloat) -> CGFloat {
        return screenHeight * value
    }
    
    public static func topSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: screenHeight * percentage, leading: 0, bottom: 0, trailing: 0)
    }
    
    public static func bottomSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, leading: 0, bottom: screenHeight * percentage, trailing: 0)
    }
    
    public static func leadingSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, leading: screenWidth * percentage, bottom: 0, trailing: 0)
    }
    
    public static func trailingSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: screenWidth * percentage)
    }
}
