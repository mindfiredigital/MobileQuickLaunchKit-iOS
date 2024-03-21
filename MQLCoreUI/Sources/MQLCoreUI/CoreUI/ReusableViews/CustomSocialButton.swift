//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

/**
 A custom social media button.
 */
public struct CustomSocialButton: View {
    /// The image representing the social media icon.
    var image: Image
    
    /// The action to perform when the button is tapped.
    var action: () -> Void
    
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /**
     Initializes the CustomSocialButton view.
     
     - Parameters:
     - image: The image representing the social media icon.
     - action: The action to perform when the button is tapped.
     */
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
