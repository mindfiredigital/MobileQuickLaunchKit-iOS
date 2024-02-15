//
//  MobileQuickLaunchKitExampleApp.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 08/12/23.
//

import SwiftUI
import GoogleSignIn
import MobileQuickLaunchKit
import MQLCore

@main
struct MobileQuickLaunchKitExampleApp: App {
    
    @StateObject public var themes = ThemeManager()
    
    init() {
        //Set the local storage value to the AppState
        MQLAppState.shared.setValues()
        
        //Set you App Base URL
        MQLConstants.baseURL = "http://localhost:3001/api/v1/" // Your App's Base URL
        
        //Set your Setting page webview url's
        SettingsLinks.privacy = "https://www.google.co.in"
        SettingsLinks.aboutUs = "https://www.google.co.in"
        SettingsLinks.help = "https://www.google.co.in"
    }
    
    var body: some Scene {
        WindowGroup {
            MQLContentView(
                mainView: MainView()
            )
            //This will help us to access the members of current theme
                .environmentObject(themes.current)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
