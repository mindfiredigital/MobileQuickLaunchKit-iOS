//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 15/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

@available(iOS 14.0, *)
struct ForgetPasswordView: View {
    
    @EnvironmentObject var theme: Theme
    @StateObject private var viewModel = ForgetPasswordViewModel()
    @Binding var isModalPresented: Bool
    
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack(alignment: .leading){
                
                //Back Button
                BackButton(action: {
                    isModalPresented.toggle()
                })
                
                Text("forgetPassword1", bundle: .module)
                    .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(ScreenSize.topSpacing(0.09))
                
                Text("forgetPasswordMsg", bundle: .module)
                    .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,5)
                    .padding(.bottom, 30)
                
                //Email Field
                ThemeTextField(placeholderText: "email".localized(), icon: Image(Icon.email, bundle: .module), keyBoardType: .emailAddress, text: $viewModel.emailTextField, error: $viewModel.emailError)
                Spacer()
                
                //Send Otp button
                Button {
                    viewModel.sendOTP(email: viewModel.emailTextField)
                } label: {
                    Text("sendOTP", bundle: .module)
                        .themeButtonModifier()
                }
                .padding(.top, 20)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.observeForgetPasswordState()
        }
        .showAlert(title: "error".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
        .loader(isLoading: $viewModel.isLoading)
        .fullScreenCover(isPresented: $viewModel.isOTPVerificationModalPresented) {
            OTPVerificationView(isModalPresented: $viewModel.isOTPVerificationModalPresented, isForgetPasswordModalPresented: $isModalPresented)
        }
    }
    
}
