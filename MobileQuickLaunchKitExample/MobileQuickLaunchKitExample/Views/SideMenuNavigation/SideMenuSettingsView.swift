//
//  SideMenuSettingsView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI


struct SideMenuSettingsView: View {
    @EnvironmentObject var theme : Theme
    @Binding var isSideMenuPresented: Bool
    @Binding var isLoginModalPresented: Bool
    
    var body: some View {
        ZStack{
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            
            VStack {
                MenuButtonView(isSideMenuPresented: $isSideMenuPresented)
                
                MQLSettingsView(isLoginModalPresented: $isLoginModalPresented )
            }
        }
    }
}

#Preview {
    SideMenuSettingsView(isSideMenuPresented: Binding.constant(false), isLoginModalPresented: Binding.constant(false))
}
