//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI

struct SocialSignInView: View {
    @ObservedObject var viewModel: SignInViewModel

        var body: some View {
            HStack {
                Spacer()
                
                // Google
                CustomSocialButton(action: {
                    viewModel.signInWithGoogle()
                }, imageName: Icon.google)
                .padding(.trailing, 10)
                
                // Apple
                CustomSocialButton(action: {
                    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                        viewModel.signInWithAppleId(viewController: rootViewController)
                    }
                }, imageName: Icon.apple)
                .padding(.trailing, 10)
                
                Spacer()
            }
        }
}

