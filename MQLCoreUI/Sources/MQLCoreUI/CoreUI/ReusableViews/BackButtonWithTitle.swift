//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 08/01/24.
//

import SwiftUI

/**
 A custom back button view with a title.
 */
public struct BackButtonWithTitle: View {
    /// The theme environment object.
    @EnvironmentObject var theme: Theme
    
    /// The action to perform when the button is tapped.
    var action: () -> Void
    
    /// The title of the button.
    var title: String
    
    /**
     Initializes the BackButtonWithTitle view.
     
     - Parameters:
     - title: The title of the button.
     - action: The action to perform when the button is tapped.
     */
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        HStack {
            BackButton(action: action)
                .frame(width: 35, alignment: .leading)
            
            // Center
            HStack(alignment: .center) {
                Spacer()
                Text(title)
                    .modifier(theme.typography.h2Style(color: theme.colors.secondary))
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
            Button{
                
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(Color.clear)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 10)
            }
        }
    }
}

