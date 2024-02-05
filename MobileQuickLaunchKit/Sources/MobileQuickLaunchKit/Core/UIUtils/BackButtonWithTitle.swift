//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 08/01/24.
//

import SwiftUI

public struct BackButtonWithTitle: View {
    @EnvironmentObject var theme: Theme
    var action: () -> Void
    var title: String
    
    public var body: some View {
        HStack {
            BackButton(action: action)
            Spacer()
            Text(NSLocalizedString(title, bundle: .module, comment: ""))
                .modifier(theme.typography.h2Style(color: theme.colors.primary))
            
            Spacer()
        }
    }
}

