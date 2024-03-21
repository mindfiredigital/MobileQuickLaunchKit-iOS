//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 15/12/23.
//

import Foundation
import SwiftUI

/**
 A custom back button view.
 */
public struct BackButton: View {
    /// The action to perform when the button is tapped.
    var action: () -> Void
    
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /**
     Initializes the BackButton view.
     
     - Parameter action: The action to perform when the button is tapped.
     */
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 24))
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                .foregroundColor(theme.colors.tertiary)
        }
    }
}
