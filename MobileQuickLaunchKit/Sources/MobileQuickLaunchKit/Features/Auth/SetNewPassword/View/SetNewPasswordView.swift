//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 15/12/23.
//

import SwiftUI

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
                    SecureTextField(iconName: Icon.lock, text: $viewModel.passwordTextField, isSecure: $viewModel.isSecurePassword, placeholderName: "newPassword", error: $viewModel.passwordError)
                        .padding(.top, 20)
                    
                    //Confirm New Password Field
                    SecureTextField(iconName: Icon.lock, text: $viewModel.confirmPasswordTextField, isSecure: $viewModel.isSecureConfirmPassword, placeholderName: "confirmNewPassword", error: $viewModel.confirmPasswordError)
                        .padding(.top, 20)
                    
                    Spacer()
                    //Submit password button
                    Button {
                        viewModel.resetPassword(password: viewModel.passwordTextField, confirmPassword: viewModel.confirmPasswordTextField)
                        
                    } label: {
                        Text("submitPassword", bundle: .module)
                            .themeButton()
                    }
                    .padding(.top, 20)
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
                .showAlert(title: "error", isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage ?? "")
                .loader(isLoading: $viewModel.isLoading)
            }
        }
    }
    
}

#Preview {
    SetNewPasswordView(isModalPresented: .constant(false), isOTPVerificationModalPresented: .constant(false), isForgetPasswordModalPresented: .constant(false))
        .environment(\.locale, Locale(identifier: "en"))
        .environmentObject(Theme.packageTheme)
}
