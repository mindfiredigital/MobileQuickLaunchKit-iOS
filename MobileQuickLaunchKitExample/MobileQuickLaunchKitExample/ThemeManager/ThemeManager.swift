//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation
import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

@available(iOS 13.0, *)
class ThemeManager: ObservableObject {
    init(){}
    
    /// Choose any pre-defined Theme object or create a new Theme object as per your need in Theme+Extensions.swift file
    /// Pre-defined themes are as follows: appTheme, theme1, theme2, theme3
    /// Colors are being initialized from the assets
    @Published var current: Theme = .appTheme
    
}

