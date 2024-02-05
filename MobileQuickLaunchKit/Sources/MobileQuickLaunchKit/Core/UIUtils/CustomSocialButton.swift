//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

struct CustomSocialButton: View {
    var action: () -> Void
    var imageName: String = "Default"
    @EnvironmentObject var theme: Theme

    var body: some View {
        Button(action: action) {
            Image(imageName, bundle: .module)
                .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(theme.colors.tertiary)
            
        }
        .padding(7)
        .background(RoundedRectangle(cornerRadius: 10).fill(theme.colors.backGroundSecondary))
        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 2, y: 2)
    }
}
