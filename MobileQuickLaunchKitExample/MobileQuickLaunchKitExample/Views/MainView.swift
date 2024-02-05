//
//  ContentView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 08/12/23.
//

import SwiftUI
import MobileQuickLaunchKit

enum RenderingMode {
    case sideMenu
    case bottomTab
}

struct MainView: View {
    
    let renderingMode: RenderingMode = .sideMenu
    
    @State public var isLoginModalPresented = !MQLAppState.shared.isUserLoggedIn()
    
    var body: some View {
        switch renderingMode {
        case .bottomTab:
            BottomTabNavigationView()
        case .sideMenu:
            MainMenuView()
        }
    }
}

#Preview {
    MainView()
}
