//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 11/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

/**
 A SwiftUI view for handling sign-in functionality.
 
 This view provides fields for entering email or username and password,
 along with options for social sign-in and Face ID authentication.
 
 Use this view to allow users to sign in to your application.
 
 Requires iOS 14.0 or later.
 
 Usage:
 MQLSignInView(isModalPresented: $isSignInModalPresented) {
 // Handle sign-in completion
 } didSignUp: {
 // Handle sign-up action
 }
 
 - Parameters:
 - isModalPresented: Binding to control the presentation of the sign-in modal.
 - didSignIn: Closure to be executed upon successful sign-in.
 - didSignUp: Closure to be executed upon tapping the sign-up button.
 
 - Note: This view relies on the `Theme` environment object and the `SignInViewModel` for its functionality.
 */

@available(iOS 14.0, *)
public struct MQLSignInView: View {
    
    @EnvironmentObject var theme : Theme
    
    @Binding var isModalPresented: Bool
    @StateObject private var viewModel = SignInViewModel()
    
    /// Closure to be executed upon successful sign-in.
    public var didSignIn: (() -> Void)?
    
    /// Closure to be executed upon tapping the sign-up button.
    public var didSignUp: (() -> Void)?
    
    /**
     Initializes a sign-in view.
     
     - Parameters:
        - isModalPresented: Binding to control the presentation of the sign-in modal.
        - didSignIn: Closure to be executed upon successful sign-in. Defaults to `nil`.
        - didSignUp: Closure to be executed upon tapping the sign-up button. Defaults to `nil`.
     */
    public init(isModalPresented: Binding<Bool>, didSignIn: (() -> Void)? = nil, didSignUp: (() -> Void)? = nil) {
        _isModalPresented = isModalPresented
        self.didSignIn = didSignIn
        self.didSignUp = didSignUp
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
                    didSignIn?()
                }
                viewModel.observeGoogleSignupEvents{
                    self.isModalPresented = false
                    didSignIn?()
                }
                viewModel.observeAppleSignInEvent{
                    self.isModalPresented = false
                    didSignIn?()
                }
            }
            .showAlert(title: "error".localized(), isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage?.localized() ?? "")
            .loader(isLoading: $viewModel.isLoading)
            .fullScreenCover(isPresented: $viewModel.isSignUpModalPresented) {
                MQLSignUpView(isModalPresented: $viewModel.isSignUpModalPresented, didSignUp: didSignUp)
            }
            .fullScreenCover(isPresented: $viewModel.isForgetPasswordModalPresented) {
                ForgetPasswordView(isModalPresented: $viewModel.isForgetPasswordModalPresented)
            }
            
        }
    }
    
    
}
