//
//  AccountsSectionView.swift
//  
//
//  Created by Hemant Sudhanshu on 08/04/24.
//

import SwiftUI
import MQLCore
import MQLCoreUI

/// A SwiftUI view for the "Accounts" section in settings.
struct AccountsSectionView: View {
    
    /// The theme environment object for styling.
    @EnvironmentObject var theme : Theme
    
    /// The view model for managing settings logic and state.
    @ObservedObject var viewModel: SettingsViewModel
    
    /// View model for managing profile editing logic and state.
    @ObservedObject var profileViewModel: EditProfileViewModel
    
    /// Binding to control the presentation of the login modal.
    @Binding var isLoginModalPresented: Bool
    
    var body: some View {
        
        // MARK: - Account
        SettingsTitleView(title: "account".localized())
        
        VStack(alignment: .leading, spacing: 5) {
            // Edit Profile
            NavigationLink(
                destination: MQLEditProfileView(),
                isActive: $viewModel.isEditProfileActive
            ) {
                HStack {
                    if let image = profileViewModel.profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 5)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .stroke(theme.colors.borderColor.opacity(0.8), lineWidth: 2)
                            )
                            .foregroundColor(theme.colors.borderColor)
                            .clipShape(Circle())
                    }
                    
                    VStack(alignment: .leading){
                        Text(profileViewModel.nameTextField)
                            .font(theme.typography.h3)
                            .foregroundColor(theme.colors.secondary)
                        
                        Text(verbatim: profileViewModel.emailTextField)
                            .font(theme.typography.body3)
                            .foregroundColor(theme.colors.secondary.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(theme.colors.secondary.opacity(0.6))
                }
                .onTapGesture {
                    viewModel.isEditProfileActive = true
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
            }
            
            Divider()
            
            // Change Password
            NavigationLink(
                destination: MQLChangePasswordView()
            ) {
                SettingsItem(title: "changePassword".localized(), iconName: "lock.fill")
            }
            
            Divider()
            
            // Logout Button
            SettingsItem(title: "logout".localized(), iconName: "rectangle.portrait.and.arrow.forward.fill")
                .onTapGesture {
                    SecureUserDefaults.removeValue(forKey: LocalStorageKeys.token)
                    MQLAppState.shared.token = nil
                    isLoginModalPresented = true
                }
                .padding(.bottom, 10)
        }
        .background(theme.colors.backGroundPrimary)
        .cornerRadius(8)
        
    }
}

