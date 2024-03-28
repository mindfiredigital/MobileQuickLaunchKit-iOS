//
//  MainTabbedView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

struct MainMenuView: View {
    @EnvironmentObject var theme : Theme
    @State public var isLoginModalPresented = !MQLAppState.shared.isUserLoggedIn()
    
    @State var isSideMenuPresented: Bool = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack{
                TabView(selection: $selectedTab) {
                    SideMenuHomeView(isSideMenuPresented: $isSideMenuPresented)
                        .tag(0)
                    SideMenuSettingsView(isSideMenuPresented: $isSideMenuPresented, isLoginModalPresented: $isLoginModalPresented)
                        .tag(1)
                }
                
                SideMenu(
                    isShowing: $isSideMenuPresented,
                    content: AnyView(SideMenuView(selectedTab: $selectedTab, isSideMenuPresented: $isSideMenuPresented))
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isLoginModalPresented) {
            MQLSignInView(isModalPresented: $isLoginModalPresented,
            didSignIn: {
                debugPrint("Hello sign in")
            },
            didSignUp: {
                debugPrint("Hello sign up")
            }
            )
        }
        .onChange(of: isLoginModalPresented) {
                  selectedTab = 0
              }
    }
}
