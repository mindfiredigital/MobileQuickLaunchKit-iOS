//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 13/12/23.
//

import SwiftUI
import MQLCoreUI
import MQLCore

struct SplashScreenView: View {
    @EnvironmentObject var theme: Theme
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack {
                Spacer()
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
