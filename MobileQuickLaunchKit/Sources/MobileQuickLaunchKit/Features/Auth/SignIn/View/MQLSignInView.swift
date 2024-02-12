//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 11/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

@available(iOS 14.0, *)
public struct MQLSignInView: View {
    
    @EnvironmentObject var theme : Theme
    
    @Binding var isModalPresented: Bool
    @StateObject private var viewModel = SignInViewModel()
    
    public init(isModalPresented: Binding<Bool>) {
        _isModalPresented = isModalPresented
    }
    public var body: some View {
        NavigationView {
            ZStack {
                theme.colors.backGroundPrimary
                    .ignoresSafeArea()
                ScrollView(.vertical) {
                    VStack(alignment: .leading){
                        // HeaderLogo View
                        HeaderLogo()
                        
                        Text("signIn", bundle: .module)
                            .modifier(theme.typography.h1Style(color: theme.colors.secondary))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 25)
                        
                        //Email or Username Field
                        ThemeTextField(placeholderText: "emailOrUsername".localized(), icon: Image(Icon.user, bundle: .module), keyBoardType: .emailAddress, text: $viewModel.emailTextField, error: $viewModel.usernameError)
                        
                        //Password Field
                        SecureTextField(icon: Image(Icon.lock, bundle: .module), text: $viewModel.passwordTextField, isSecure: $viewModel.isSecure, placeholderName: "password".localized(), error: $viewModel.passwordError)
                            .padding(.top, 15)
                        
                        Button("forgetPassword".localized()){
                            viewModel.isForgetPasswordModalPresented.toggle()
                        }
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .padding(.top, 15)
                        .padding(.trailing,5)
                        .font(theme.typography.h4)
                        .foregroundColor(theme.colors.primary)
                        
                        //Sign In button
                        Button {
                            viewModel.login(emailOrUsername: viewModel.emailTextField, password: viewModel.passwordTextField)
                        } label: {
                            Text("signIn", bundle: .module)
                                .themeButtonModifier()
                        }
                        .padding(.top, 15)
                        
                        // Social login section
                        Text("signInOptionMsg", bundle: .module)
                            .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                            .frame(maxWidth: .infinity)
                            .padding(.top, 15)
                        
                        // Social Sign In View
                        SocialSignInView(viewModel: viewModel)
                            .padding(.top, 10)
                        
                        // Face ID view
                        if MQLAppState.shared.email != nil && MQLAppState.shared.password != nil {
                            Button(action: {
                                viewModel.faceIdAuthentication()
                            }){
                                FaceIDView()
                            }
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                        }
                        
                        
                        Spacer()
                        // Sign up button section
                        BottomSignUpView(isSignUpModalPresented: $viewModel.isSignUpModalPresented)
                    }
                    .padding(.horizontal, 20)
                    .frame(minHeight: ScreenSize.screenHeight - (ScreenSize.topSafeAreaHeight + ScreenSize.bottomSafeAreaHeight))
                }
            }
            .onAppear{
                viewModel.observeSignInState{
                    self.isModalPresented = false
                }
                viewModel.observeGoogleSignupEvents{
                    self.isModalPresented = false
                }
                viewModel.observeAppleSignInEvent{
                    self.isModalPresented = false
                }
            }
            .showAlert(title: "error".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
            .loader(isLoading: $viewModel.isLoading)
            .fullScreenCover(isPresented: $viewModel.isSignUpModalPresented) {
                MQLSignUpView(isModalPresented: $viewModel.isSignUpModalPresented)
            }
            .fullScreenCover(isPresented: $viewModel.isForgetPasswordModalPresented) {
                ForgetPasswordView(isModalPresented: $viewModel.isForgetPasswordModalPresented)
            }
            
        }
    }
    
    
}
