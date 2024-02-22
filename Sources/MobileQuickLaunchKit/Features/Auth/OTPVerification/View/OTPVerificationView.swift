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
struct OTPVerificationView: View {
    
    @EnvironmentObject var theme: Theme
    @Binding var isModalPresented: Bool
    @Binding var isForgetPasswordModalPresented: Bool
    @StateObject private var viewModel = OTPVerificationViewModel()

    
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
                
                Spacer()
                
                
                //Verify OTP button
                Button {
                    viewModel.verifyOTP()
                } label: {
                    Text("verifyOTP", bundle: .module)
                        .themeButtonModifier()
                }
                
                .padding(.top, 20)
                
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
    
    /// This func is used to show the otp accepter text view
    private func otpText(text: String) -> some View {
        
        return Text(text)
            .modifier(theme.typography.h3Style(color: theme.colors.secondary))
            .frame(width: viewModel.textBoxWidth, height: viewModel.textBoxHeight, alignment: .center)
            .background(VStack{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(theme.colors.secondary, lineWidth: 2)
            })
            .padding(viewModel.paddingOfBox)
    }
}




