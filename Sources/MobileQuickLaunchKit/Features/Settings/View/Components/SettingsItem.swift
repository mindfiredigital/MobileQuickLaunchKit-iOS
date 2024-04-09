//
//  SwiftUIView.swift
//  
//
//  Created by Hemant Sudhanshu on 08/04/24.
//

import SwiftUI
import MQLCoreUI

struct SettingsItem: View {
    @EnvironmentObject var theme : Theme
    var title: String
    var iconName: String
    
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.trailing, 10)
                .padding(.leading, 2)
                .foregroundColor(theme.colors.secondary.opacity(0.7))
            
            Text(title)
                .font(theme.typography.body1)
                .foregroundColor(theme.colors.secondary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(theme.colors.secondary.opacity(0.6))
        }
        .frame(height: 35)
        .padding(.horizontal, 8)
    }
}

#Preview {
    SettingsItem(title: "Hi", iconName: "chevron.left")
}
