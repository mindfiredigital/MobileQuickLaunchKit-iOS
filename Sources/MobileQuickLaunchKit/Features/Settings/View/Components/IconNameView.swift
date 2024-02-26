//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 02/01/24.
//

import SwiftUI
import MQLCoreUI

struct IconNameView: View {
    
    @EnvironmentObject var theme : Theme
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(icon, bundle: .module)
                .padding(.trailing, 10)
                .padding(.leading, 0)
                .foregroundColor(theme.colors.secondary)
            
            Text(title)
                .font(theme.typography.h2)
                .foregroundColor(theme.colors.secondary)
        }
    }
}

