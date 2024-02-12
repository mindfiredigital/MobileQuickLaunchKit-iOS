//
//  SideMenuHomeView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

struct SideMenuHomeView: View {
    @EnvironmentObject var theme : Theme
    @Binding var isSideMenuPresented: Bool
    
    var body: some View {
        ZStack{
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            
            VStack {
                MenuButtonView(isSideMenuPresented: $isSideMenuPresented)
                
                HomeView()
            }
        }
    }
}

#Preview {
    SideMenuHomeView(isSideMenuPresented: Binding.constant(false))
}
