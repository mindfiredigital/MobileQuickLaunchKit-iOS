//
//  SwiftUIView.swift
//  
//
//  Created by Hemant Sudhanshu on 08/04/24.
//

import SwiftUI
import MQLCoreUI

struct SettingsTitleView: View {
    @EnvironmentObject var theme : Theme
    var title: String
    
    var body: some View {
        Text(title)
            .modifier(theme.typography.h3Style(color: theme.colors.secondary))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            .padding(.bottom, 10)
    }
}

#Preview {
    SettingsTitleView( title: "Title")
}
