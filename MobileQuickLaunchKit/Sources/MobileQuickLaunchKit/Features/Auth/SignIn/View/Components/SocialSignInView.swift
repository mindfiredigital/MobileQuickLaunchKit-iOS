//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI
import MQLCoreUI

struct SocialSignInView: View {
    @ObservedObject var viewModel: SignInViewModel

        var body: some View {
            HStack {
                Spacer()
                
                // Google
                CustomSocialButton(image: Image(Icon.google, bundle: .module), action: {
                    viewModel.signInWithGoogle()
                })
                .padding(.trailing, 10)
                
                // Apple
                CustomSocialButton(image: Image(Icon.apple, bundle: .module), action: {
                    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                        viewModel.signInWithAppleId(viewController: rootViewController)
                    }
                })
                .padding(.trailing, 10)
                
                Spacer()
            }
        }
}

