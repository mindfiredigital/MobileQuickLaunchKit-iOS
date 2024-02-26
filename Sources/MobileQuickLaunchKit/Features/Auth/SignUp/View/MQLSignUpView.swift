//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 14/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

struct MQLSignUpView: View {
    
    @EnvironmentObject var theme: Theme
    
    @StateObject private var viewModel = SignUpViewModel()
    @Binding var isModalPresented: Bool
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(alignment: .leading){
                    Spacer()
                    
                    Text("signUp", bundle: .module)
                        .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 25)
                    
                    //Fullname field
                    ThemeTextField(placeholderText: "fullName".localized(), icon: Image(Icon.user, bundle: .module), text: $viewModel.fullnameTextField, error: $viewModel.fullnameError)
                        .padding(.bottom,(viewModel.fullnameError == nil) ? 20 : 0)
                    
                    //Email Field
                    ThemeTextField(placeholderText: "email".localized(), icon: Image(Icon.user, bundle: .module), keyBoardType: .emailAddress, text: $viewModel.emailTextField, error: $viewModel.emailError)
                    
                    //Password Field
                    SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.passwordTextField, isSecure: $viewModel.isSecurePassword, placeholderName: "password".localized(), error: $viewModel.passwordError)
                        .padding(.top, 20)
                    
                    //Confirm Password Field
                    SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.confirmPasswordTextField, isSecure: $viewModel.isSecureConfirmPassword, placeholderName: "confirmPassword".localized(), error: $viewModel.confirmPasswordError)
                        .padding(.top, 20)
                    
                    //Sign Up button
                    Button {
                        viewModel.signUp(fullname: viewModel.fullnameTextField, email: viewModel.emailTextField, password: viewModel.passwordTextField, confirmPassword: viewModel.confirmPasswordTextField)
                    } label: {
                        Text("signUp", bundle: .module)
                            .themeButtonModifier()
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    // Sign in button section
                    HStack{
                        Text("alreadyHaveAccount", bundle: .module)
                            .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                        Button("signIn".localized()){
                            isModalPresented.toggle()
                        }
                        .font(theme.typography.h4)
                        .foregroundColor(theme.colors.primary)
                    }
                    .padding(.bottom, 15)
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
                .frame(minHeight: ScreenSize.screenHeight - (ScreenSize.topSafeAreaHeight + ScreenSize.bottomSafeAreaHeight))
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            viewModel.observeSignUpState{
                DispatchQueue.main.async {
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
                }
            }
        }
        .showAlert(title: "error".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
        .loader(isLoading: $viewModel.isLoading)
    }
}

