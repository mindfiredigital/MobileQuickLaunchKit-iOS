//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 15/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

/**
 A SwiftUI view for setting a new password.
 
 This view allows users to set a new password after successful verification of the OTP.

 Usage:
 
 SetNewPasswordView(isModalPresented: $isSetNewPasswordModalPresented, isOTPVerificationModalPresented: $isOTPVerificationModalPresented, isForgetPasswordModalPresented: $isForgetPasswordModalPresented)
 
 - Note: This view relies on the `Theme` environment object and the `SetNewPasswordViewModel` for its functionality.

 - Important: Before using this view, ensure that the user has completed OTP verification and is authorized to set a new password.
 */
 
struct SetNewPasswordView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel = SetNewPasswordViewModel()
    
    @Binding var isModalPresented: Bool
    @Binding var isOTPVerificationModalPresented: Bool
    @Binding var isForgetPasswordModalPresented: Bool
    
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    //Back Button
                    BackButton(action: {
                        isModalPresented.toggle()
                    })
                    
                    Text("setNewPassword", bundle: .module)
                        .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(ScreenSize.topSpacing(0.09))
                    
                    Text("setNewPasswordMsg", bundle: .module)
                        .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top,5)
                    
                    //New Password Field
                    SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.passwordTextField, isSecure: $viewModel.isSecurePassword, placeholderName: "newPassword".localized(), error: $viewModel.passwordError)
                        .padding(.top, 20)
                    
                    //Confirm New Password Field
                    SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.confirmPasswordTextField, isSecure: $viewModel.isSecureConfirmPassword, placeholderName: "confirmNewPassword".localized(), error: $viewModel.confirmPasswordError)
                        .padding(.top, 20)
                    
                    //Submit password button
                    Button {
                        viewModel.resetPassword(password: viewModel.passwordTextField, confirmPassword: viewModel.confirmPasswordTextField)
                        
                    } label: {
                        Text("submitPassword", bundle: .module)
                            .themeButtonModifier()
                    }
                    .padding(.top, 70)
                    Spacer()
                }
                
                .padding(.horizontal, 20)
                .frame(minHeight: ScreenSize.screenHeight - (ScreenSize.topSafeAreaHeight + ScreenSize.bottomSafeAreaHeight))
                .navigationBarBackButtonHidden()
                .onAppear {
                    viewModel.observeResetPasswordState{
                        self.isModalPresented.toggle()
                        self.isOTPVerificationModalPresented.toggle()
                        self.isForgetPasswordModalPresented.toggle()
                    }
                }
                .showAlert(title: "error".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
                .loader(isLoading: $viewModel.isLoading)
            }
        }
    }
    
}
