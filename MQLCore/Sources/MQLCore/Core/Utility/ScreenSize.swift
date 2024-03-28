//
//  File.swift
//
//
//  Created by Satyam Tripathi on 13/12/23.
//

import Foundation
import SwiftUI

/**
 A utility struct providing screen-related information and scaling functions for layout calculations.

 ScreenSize encapsulates functionality to retrieve screen dimensions, safe area insets, and scale values based on the screen size.
 */
public struct ScreenSize {
    /// Returns the width of the screen.
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// Returns the height of the screen
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// Returns the top safe area height of the screen.
    public static var topSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    /// Returns the bottom safe area height of the screen.
    public static var bottomSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    /// Returns the scaled width of the screen based on the provided value.
    /// - Parameter value: The value to be scaled.
    /// - Returns: The scaled width value.
    public static func scaleWidth(_ value: CGFloat) -> CGFloat {
        return screenWidth * value
    }
    
    /// Returns the scaled height of the screen based on the provided value.
    /// - Parameter value: The value to be scaled.
    /// - Returns: The scaled height value.
    public static func scaleHeight(_ value: CGFloat) -> CGFloat {
        return screenHeight * value
    }
    
    /// Returns edge insets with the scaled top spacing based on the screen height and the provided percentage value.
    /// - Parameter percentage: The percentage value to scale.
    /// - Returns: Edge insets with scaled top spacing.
    public static func topSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: screenHeight * percentage, leading: 0, bottom: 0, trailing: 0)
    }
    
    /// Returns edge insets with the scaled bottom spacing based on the screen height and the provided percentage value.
    /// - Parameter percentage: The percentage value to scale.
    /// - Returns: Edge insets with scaled bottom spacing.
    public static func bottomSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, leading: 0, bottom: screenHeight * percentage, trailing: 0)
    }
    
    /// Returns edge insets with the scaled leading spacing based on the screen width and the provided percentage value.
    /// - Parameter percentage: The percentage value to scale.
    /// - Returns: Edge insets with scaled leading spacing.
    public static func leadingSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, leading: screenWidth * percentage, bottom: 0, trailing: 0)
    }
    
    /// Returns edge insets with the scaled trailing spacing based on the screen width and the provided percentage value.
    /// - Parameter percentage: The percentage value to scale.
    /// - Returns: Edge insets with scaled trailing spacing.
    public static func trailingSpacing(_ percentage: CGFloat) -> EdgeInsets {
        return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: screenWidth * percentage)
    }
}
