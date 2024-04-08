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
 View for OTP verification.
 
 This view presents a UI for entering and verifying an OTP (One-Time Password) for verification purposes.
 
 - Note: This view requires the `OTPVerificationViewModel` to manage the OTP verification logic and state.
 
 */

@available(iOS 14.0, *)
struct OTPVerificationView: View {
    
    /// Environment object for theme styling.
    @EnvironmentObject var theme: Theme
    
    /// Binding to control the presentation of the OTP verification modal.
    @Binding var isModalPresented: Bool
    
    /// Binding to control the presentation of the forget password modal.
    @Binding var isForgetPasswordModalPresented: Bool
    
    /// View model for managing OTP verification logic and state.
    @StateObject private var viewModel = OTPVerificationViewModel()
    
    /// Body of the OTP verification view.
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack(alignment: .leading){
                //Back Button
                BackButton(action: {
                    isModalPresented.toggle()
                })
                
                Text("otpVerification", bundle: .module)
                    .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(ScreenSize.topSpacing(0.09))
                Text("otpVerificationMsg", bundle: .module)
                    .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top,5)
                    .padding(.bottom, 25)
                
                //OTP accepter view
                ZStack {
                    
                    HStack (spacing: viewModel.spaceBetweenBoxes){
                        otpText(text: viewModel.otp1)
                        otpText(text: viewModel.otp2)
                        otpText(text: viewModel.otp3)
                        otpText(text: viewModel.otp4)
                        otpText(text: viewModel.otp5)
                        otpText(text: viewModel.otp6)
                    }
                    
                    TextField("", text: $viewModel.otpField)
                        .frame(width: viewModel.isFocused ? 0 : viewModel.textFieldOriginalWidth, height: viewModel.textBoxHeight)
                        .disabled(viewModel.isTextFieldDisabled)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .background(Color.clear)
                        .keyboardType(.numberPad)
                }
                
                // OTP error text
                if let otpError = viewModel.otpError, !otpError.isEmpty {
                    Text(otpError.localized())
                        .foregroundColor(theme.colors.error)
                        .font(theme.typography.body1)
                }
                
                //Verify OTP button
                Button {
                    viewModel.verifyOTP()
                } label: {
                    Text("verifyOTP", bundle: .module)
                        .themeButtonModifier()
                }
                
                .padding(.top, 70)
                
                Spacer()
                
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.observeVerifyOtpState()
        }
        .showAlert(title: "error".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
        .loader(isLoading: $viewModel.isLoading)
        .fullScreenCover(isPresented: $viewModel.isSetNewPasswordModalPresented) {
            SetNewPasswordView(isModalPresented: $viewModel.isSetNewPasswordModalPresented, isOTPVerificationModalPresented: $isModalPresented, isForgetPasswordModalPresented: $isForgetPasswordModalPresented)
        }
    }
    
    /**
     Displays a text view for OTP accepter.
     
     - Parameter text: The text for the OTP box.
     - Returns: A text view for displaying the OTP box.
     */
    private func otpText(text: String) -> some View {
        
        return Text(text)
            .modifier(theme.typography.h3Style(color: theme.colors.secondary))
            .frame(width: viewModel.textBoxWidth, height: viewModel.textBoxHeight, alignment: .center)
            .background(VStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(theme.colors.borderColor, lineWidth: 2)
            })
            .padding(viewModel.paddingOfBox)
    }
}




