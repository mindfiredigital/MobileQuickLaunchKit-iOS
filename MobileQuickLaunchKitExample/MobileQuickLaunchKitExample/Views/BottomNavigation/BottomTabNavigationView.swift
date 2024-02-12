//
//  BottomTabNavigationView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Satyam Tripathi on 10/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

struct BottomTabNavigationView: View {
    @EnvironmentObject var theme : Theme
    @State private var selectedTab = 0
    @State public var isLoginModalPresented = !MQLAppState.shared.isUserLoggedIn()
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                MQLSettingsView(isLoginModalPresented: $isLoginModalPresented)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(1)
            }
            .accentColor(theme.colors.primary)
            .onAppear {
                UITabBar.appearance().backgroundColor = UIColor(theme.colors.backGroundPrimary)
                UITabBar.appearance().barTintColor = UIColor(theme.colors.backGroundPrimary)
            }
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isLoginModalPresented) {
            MQLSignInView(isModalPresented: $isLoginModalPresented)
        }
    }
}

#Preview {
    BottomTabNavigationView()
}
