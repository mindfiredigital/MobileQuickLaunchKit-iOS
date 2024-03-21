//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

/**
 A view for displaying settings options such as account management, privacy settings, and logout functionality.

 This view provides options for users to edit their profile, change their password, view privacy information, and access help and about us pages.

 - Requires: `Theme` environment object for styling, `SettingsViewModel` for managing settings logic and state, and appropriate navigation views for handling navigation to other views.

 - Note: Ensure that the necessary navigation links and actions are properly configured in the `SettingsViewModel`.
 */
public struct MQLSettingsView: View {
    /// The theme environment object for styling.
       @EnvironmentObject var theme : Theme
       
       /// The view model for managing settings logic and state.
       @StateObject private var viewModel = SettingsViewModel()
       
       /// Binding to control the presentation of the login modal.
       @Binding var isLoginModalPresented: Bool
       
       /// Initializes a new instance of `MQLSettingsView`.
       ///
       /// - Parameter isLoginModalPresented: Binding to control the presentation of the login modal.
    public init(isLoginModalPresented: Binding<Bool>) {
        _isLoginModalPresented = isLoginModalPresented
    }
    
    /// The body of the settings view.
    public var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(alignment: .leading){
                    
                    // Heading Text
                    Text("settings", bundle: .module)
                        .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.bottom, 25)
                    
                    // Account Section
                    IconNameView(title: "account".localized(), icon: Icon.account)
                    
                    // Edit Profile
                    NavigationLink(
                        destination: MQLEditProfileView(),
                        isActive: $viewModel.isEditProfileActive
                    ) {
                        SettingsButton(title: "editProfile".localized()) {
                            viewModel.isEditProfileActive = true
                        }
                    }
                    
                    // Change Password
                    NavigationLink(
                        destination: MQLChangePasswordView(),
                        isActive: $viewModel.isChangePasswordActive
                    ) {
                        SettingsButton(title: "changePassword".localized()) {
                            viewModel.isChangePasswordActive = true
                        }
                    }

                    // Privacy
                    NavigationLink(
                        destination: WebView(url: $viewModel.webViewURL, title: $viewModel.webViewTitle),
                        isActive: $viewModel.isWebViewActive
                    ) {
                        SettingsButton(title: "privacy".localized()) {
                            viewModel.webViewURL = SettingsLinks.privacy
                            viewModel.isWebViewActive = true
                            viewModel.webViewTitle = "privacy"
                        }
                    }
                   
                    // Logout Button
                    SettingsButton(title: "logout".localized()) {
                        debugPrint("logout")
                        SecureUserDefaults.removeValue(forKey: LocalStorageKeys.token)
                        MQLAppState.shared.token = nil
                        isLoginModalPresented = true
                    }
                    
                    // Other Section
                    IconNameView(title: "other".localized(), icon: Icon.other)
                        .padding(.top, 30)
                    
                    // Help
                    NavigationLink(
                        destination: WebView(url: $viewModel.webViewURL, title: $viewModel.webViewTitle),
                        isActive: $viewModel.isWebViewActive
                    ) {
                        SettingsButton(title: "help".localized()) {
                            viewModel.webViewURL = SettingsLinks.help
                            viewModel.isWebViewActive = true
                            viewModel.webViewTitle = "help"
                        }
                    }
                    
                    // About Us
                    NavigationLink(
                        destination: WebView(url: $viewModel.webViewURL, title: $viewModel.webViewTitle),
                        isActive: $viewModel.isWebViewActive
                    ) {
                        SettingsButton(title: "aboutUs".localized()) {
                            viewModel.webViewURL = SettingsLinks.aboutUs
                            viewModel.isWebViewActive = true
                            viewModel.webViewTitle = "aboutUs"
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 29)
                .loader(isLoading: $viewModel.isLoading)
            }
        }
        .fullScreenCover(isPresented: $isLoginModalPresented) {
            MQLSignInView(isModalPresented: $isLoginModalPresented)
        }
        
    }
}

