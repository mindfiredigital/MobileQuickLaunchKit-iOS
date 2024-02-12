//
//  SideMenuView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI

enum MenuRowType: Int, CaseIterable{
    case home = 0
    case settings
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .settings:
            return "gearshape.fill"
        }
    }
}

struct SideMenuView: View {
    @EnvironmentObject var theme : Theme
    @Binding var selectedTab: Int
    @Binding var isSideMenuPresented: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    headerView()
                        .frame(height: 140)
                        .padding(.bottom, 30)
                    
                    ForEach(MenuRowType.allCases, id: \.self){ row in
                        menuItemView(isSelected: selectedTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedTab = row.rawValue
                            isSideMenuPresented.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    theme.colors.backGroundPrimary
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func headerView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image("profile-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(theme.colors.primary.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(50)
                Spacer()
            }
            
            Text("Demo User")
                .font(theme.typography.h3)
                .foregroundColor(theme.colors.secondary)
            
            Text("demouser@mail.com")
                .font(theme.typography.body3)
                .foregroundColor(theme.colors.secondary.opacity(0.8))
        }
    }
    
    func menuItemView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? theme.colors.primary : .clear)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? theme.colors.buttonTextPrimary : theme.colors.secondary)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(theme.typography.h4)
                        .foregroundColor(isSelected ? theme.colors.buttonTextPrimary : theme.colors.secondary)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? theme.colors.primary.opacity(0.8) : .clear, .clear], startPoint: .leading, endPoint: .trailing)
        )
    }
}
