//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 08/01/24.
//

import SwiftUI
import MQLCore
import MQLCoreUI

/**
 View for changing the user's password.
 
 This view allows the user to change their password by entering a new password and confirming it.
 
 - Note: This view requires the `ChangePasswordViewModel` to manage the password change logic and state.
 
 Usage:
 MQLChangePasswordView()
 
 - Requires: `Theme` environment object to apply consistent styling throughout the app.
 */
public struct MQLChangePasswordView: View {
    
    /// Environment object for theme styling.
    @EnvironmentObject var theme: Theme
    
    /// View model for managing password change logic and state.
    @StateObject var viewModel = ChangePasswordViewModel()
    
    /// Binding to control the presentation mode.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// Initializes a new instance of the change password view.
    public init() {}
    
    /// Body of the change password view.
    public var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    //Back Button with title
                    BackButtonWithTitle(title: "changePassword".localized(), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    .padding(.trailing, 29)
                    
                    //New Password Field
                    SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.passwordTextField, isSecure: $viewModel.isSecurePassword, placeholderName: "newPassword".localized(), error: $viewModel.passwordError)
                        .padding(.top, 50)
                    
                    //Confirm New Password Field
                    SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.confirmPasswordTextField, isSecure: $viewModel.isSecureConfirmPassword, placeholderName: "confirmNewPassword".localized(), error: $viewModel.confirmPasswordError)
                        .padding(.top, 20)
                    Spacer()
                    //Submit password button
                    Button {
                        viewModel.resetPassword(password: viewModel.passwordTextField, confirmPassword: viewModel.confirmPasswordTextField)
                        
                    } label: {
                        Text("submitPassword", bundle: .module)
                            .themeButtonModifier()
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }
                
                .padding(.horizontal, 20)
                .frame(minHeight: ScreenSize.screenHeight - (ScreenSize.topSafeAreaHeight + ScreenSize.bottomSafeAreaHeight))
                .navigationBarBackButtonHidden()
                .onAppear {
                    viewModel.observeResetPasswordState()
                }
                .showAlert(title: "appName".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
                .loader(isLoading: $viewModel.isLoading)
            }
        }
    }
}

#Preview {
    MQLChangePasswordView()
}
