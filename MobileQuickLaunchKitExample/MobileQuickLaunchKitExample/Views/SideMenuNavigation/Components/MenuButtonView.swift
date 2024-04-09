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
    
    var title: String
    
    var body: some View {
        HStack{
            Button{
                isSideMenuPresented.toggle()
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(theme.colors.secondary)
                    .frame(width: 35, height: 35)
                    .padding(.leading, 10)
            }
            
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

#Preview {
    MenuButtonView(isSideMenuPresented: Binding.constant(false), title: "Home")
}
