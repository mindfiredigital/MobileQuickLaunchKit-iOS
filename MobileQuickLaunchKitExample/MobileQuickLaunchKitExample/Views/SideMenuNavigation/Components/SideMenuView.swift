//
//  SideMenuView.swift
//  MobileQuickLaunchKitExample
//
//  Created by Hemant Sudhanshu on 11/01/24.
//

import SwiftUI
import MobileQuickLaunchKit
import MQLCoreUI
import MQLCore

enum MenuRowType: Int, CaseIterable{
    case home = 0
    case settings
    case logout
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .settings:
            return "Settings"
        case .logout:
            return "Logout"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .settings:
            return "gearshape.fill"
        case .logout:
            return "rectangle.portrait.and.arrow.forward"
        }
    }
}

struct SideMenuView: View {
    @EnvironmentObject var theme : Theme
    @Binding var selectedTab: Int
    @Binding var isSideMenuPresented: Bool
    @Binding public var isLoginModalPresented: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    headerView()
                        .padding(.bottom, 10)
                    
                    ForEach(MenuRowType.allCases, id: \.self){ row in
                        menuItemView(isSelected: selectedTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedTab = row.rawValue
                            isSideMenuPresented.toggle()
                            
                            if row == .logout {
                                SecureUserDefaults.removeValue(forKey: LocalStorageKeys.token)
                                MQLAppState.shared.token = nil
                                isLoginModalPresented = true
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Text("Version: v\(getAppVersion())(\(getBuildNumber()))")
                            .font(theme.typography.body1)
                            .multilineTextAlignment(.center)
                            .padding(20)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
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
        
        HStack{
            Image(systemName: "person.circle.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .overlay(
                    Circle()                            
                        .stroke(theme.colors.borderColor.opacity(0.8), lineWidth: 2)
                )
                .foregroundStyle(theme.colors.borderColor)
                .mask(Circle())
            
            VStack(alignment: .leading){
                Text("Demo User")
                    .font(theme.typography.h3)
                    .foregroundColor(theme.colors.secondary)
                
                Text(verbatim: "demouser@mail.com")
                    .font(theme.typography.body3)
                    .foregroundColor(theme.colors.secondary.opacity(0.8))
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        
    }
    
    func menuItemView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    
                    ZStack{
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? theme.colors.buttonTextPrimary : theme.colors.secondary.opacity(0.7))
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(theme.typography.h4)
                        .foregroundColor(isSelected ? theme.colors.buttonTextPrimary : theme.colors.secondary)
                    Spacer()
                }
            }
            .padding(10)
        }
        .frame(height: 50)
        .background(
            isSelected ? theme.colors.primary.opacity(0.8) : .clear
        )
        .cornerRadius(8)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
    
    func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }
    
    func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "Unknown"
    }
}
