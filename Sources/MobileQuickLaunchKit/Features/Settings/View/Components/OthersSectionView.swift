//
//  OthersSectionView.swift
//
//
//  Created by Hemant Sudhanshu on 08/04/24.
//

import SwiftUI
import MQLCoreUI

/// A SwiftUI view for the "Others" section in settings.
struct OthersSectionView: View {
    /// The theme environment object for styling.
    @EnvironmentObject var theme : Theme

    var body: some View {
        SettingsTitleView(title: "other".localized())
        
        VStack(alignment: .leading, spacing: 5) {
            // Privacy
            NavigationLink(
                destination: WebView(url: SettingsLinks.privacy, title: "privacy")
            ) {
                SettingsItem(title: "privacy".localized(), iconName: "checkmark.shield.fill")
            }
            .padding(.top, 10)
            
            Divider()
            
            // Help
            NavigationLink(
                destination: WebView(url: SettingsLinks.help, title: "help")
            ) {
                
                SettingsItem(title: "help".localized(), iconName: "questionmark.circle.fill")
            }
            
            
            Divider()
            
            // About Us
            NavigationLink(
                destination: WebView(url: SettingsLinks.aboutUs, title: "aboutUs")
            ) {
                SettingsItem(title: "aboutUs".localized(), iconName: "info.circle.fill")
            }
            .padding(.bottom, 10)
        }
        .background(theme.colors.backGroundPrimary)
        .cornerRadius(8)
    }
}

#Preview {
    OthersSectionView()
}
