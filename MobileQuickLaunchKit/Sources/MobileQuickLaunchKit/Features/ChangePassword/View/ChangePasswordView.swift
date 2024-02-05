//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 08/01/24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel = ChangePasswordViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    //Back Button with title
                    BackButtonWithTitle(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, title: "changePassword")
                    .padding(.trailing, 29)
                    
                    //New Password Field
                    SecureTextField(iconName: Icon.lock, text: $viewModel.passwordTextField, isSecure: $viewModel.isSecurePassword, placeholderName: "newPassword", error: $viewModel.passwordError)
                        .padding(.top, 50)
                    
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
                .showAlert(title: "appName", isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage ?? "")
                .loader(isLoading: $viewModel.isLoading)
            }
        }
    }
}

#Preview {
    ChangePasswordView()
}
