//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

public struct CustomSocialButton: View {
    var image: Image
    var action: () -> Void
    @EnvironmentObject var theme: Theme
    
    public init(image: Image, action: @escaping () -> Void) {
        self.action = action
        self.image = image
    }

    public var body: some View {
        Button(action: action) {
            image
                .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(theme.colors.tertiary)
            
        }
        .padding(7)
        .background(RoundedRectangle(cornerRadius: 10).fill(theme.colors.backGroundSecondary))
        .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 2, y: 2)
    }
}
