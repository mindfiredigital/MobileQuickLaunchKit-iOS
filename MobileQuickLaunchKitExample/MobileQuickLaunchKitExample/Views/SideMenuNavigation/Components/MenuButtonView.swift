//
//  MenuButtonView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

struct MenuButtonView: View {
    @EnvironmentObject var theme : Theme
    @Binding var isSideMenuPresented: Bool
    
    var body: some View {
        HStack{
            Button{
                isSideMenuPresented.toggle()
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(theme.colors.tertiary)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 10)
            }
            Spacer()
        }
    }
}

#Preview {
    MenuButtonView(isSideMenuPresented: Binding.constant(false))
}
