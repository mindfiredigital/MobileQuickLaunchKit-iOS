//
//  HomeView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit

struct HomeView: View {
    @EnvironmentObject var theme : Theme
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            Text("Welcome")
                .font(theme.typography.h2)
                .foregroundColor(theme.colors.secondary)
        }
    }
}

#Preview {
    HomeView()
}
