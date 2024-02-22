//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 02/01/24.
//

import SwiftUI
import MQLCoreUI

struct SettingsButton: View {
    
    @EnvironmentObject var theme : Theme
    
    var title: String
    var action: () -> Void // Closure for the action to be performed when the button is tapped
    
    var body: some View {
        Button(action: {
            action() // Execute the provided action
        }) {
            Text(title) // Use the provided title
                .foregroundColor(theme.colors.buttonTextSecondary)
                .font(theme.typography.body1)
        }
        .padding(.top, 10)
        .padding(.leading, 5)
    }
}

