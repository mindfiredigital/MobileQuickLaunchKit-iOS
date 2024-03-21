//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 13/12/23.
//

import SwiftUI
import MQLCoreUI
import MQLCore

/**
 A view displayed when the app launches, showing the company logo or branding.

 The `SplashScreenView` is typically used to provide a visually appealing entry point to the app before transitioning to the main content.
*/
struct SplashScreenView: View {
    @EnvironmentObject var theme: Theme
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack {
                Spacer()
                // Company Logo
                Image(Icon.companyLogo, bundle: .main)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ScreenSize.scaleHeight(0.13), height: ScreenSize.scaleHeight(0.13))
                    .offset(x: 0, y: -20)
                    .foregroundColor(theme.colors.primary)
                Spacer()
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
