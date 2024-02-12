//
//  HomeView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCore
import MQLCoreUI

struct HomeView: View {
    @EnvironmentObject var theme : Theme
    @State var isPresented: Bool = true
    @State private var date = Date()
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack {
                Text("Welcome")
                    .font(theme.typography.h2)
                    .foregroundColor(theme.colors.secondary)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        Utilities.openShareSheet(activityItem: "Hi there!")
                        
                    }, label: {
                        Text("Share")
                            .padding(10)
                    })
                }
            }
        }
        .showToast(message: "Welcome", isPresented: $isPresented)
    }
}

#Preview {
    HomeView()
}
