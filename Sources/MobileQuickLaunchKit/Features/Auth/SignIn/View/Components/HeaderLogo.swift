//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI
import MQLCore
import MQLCoreUI

struct HeaderLogo: View {
    
    @EnvironmentObject var theme : Theme
    var body: some View {
        HStack {
            Spacer() // Spacer to push the image to the center
            Image(Icon.companyLogo, bundle: .main)
                .resizable()
                .frame(width: ScreenSize.scaleWidth(0.3), height: ScreenSize.scaleHeight(0.13))
                .padding(ScreenSize.topSpacing(0.01))
                .foregroundColor(theme.colors.primary)
            Spacer() // Spacer to push the image to the center
        }
    }
}

#Preview {
    HeaderLogo()
}
