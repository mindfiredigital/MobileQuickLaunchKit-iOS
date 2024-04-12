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
    
    /// View model for managing profile editing logic and state.
    @StateObject private var profileViewModel = EditProfileViewModel()
    
    
    /// The body of the settings view.
    public var body: some View {
        ZStack {
            theme.colors.backGroundSecondary
                .ignoresSafeArea()
            
            ScrollView(.vertical) {
                    
                    VStack(alignment: .leading) {
                        // MARK: - Account
                        AccountsSectionView(viewModel: viewModel, profileViewModel: profileViewModel, isLoginModalPresented: $isLoginModalPresented)
                        
                        // MARK: - App
                        ThemeSwitcherView()
                        
                        // MARK: - Other
                        OthersSectionView()
                        
                        // MARK: - App Version
                        HStack {
                            Spacer()
                            Text("version".localized() + ": v\(getAppVersion())(\(getBuildNumber()))")
                                .font(theme.typography.body1)
                                .multilineTextAlignment(.center)
                                .padding(10)
                            Spacer()
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 10)
                
                .loader(isLoading: $viewModel.isLoading)
                .loader(isLoading: $profileViewModel.isLoading)
                .showAlert(title: profileViewModel.alertTitle.localized(), isPresented: $profileViewModel.isAlertPresented, message: profileViewModel.alertMessage?.localized() ?? "")
            }
        }
        .onAppear() {
            profileViewModel.getUserDetail()
            profileViewModel.observeGetUserEvent()
        }
        .fullScreenCover(isPresented: $isLoginModalPresented) {
            MQLSignInView(isModalPresented: $isLoginModalPresented)
        }
    }
    
    // MARK: - FUNCTIONS
    func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }
    
    func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "Unknown"
    }
}

