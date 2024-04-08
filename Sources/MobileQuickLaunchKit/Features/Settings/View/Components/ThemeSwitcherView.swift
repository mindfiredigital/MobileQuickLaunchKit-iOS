//
//  ThemeSwitcherView.swift
//
//
//  Created by Hemant Sudhanshu on 08/04/24.
//

import SwiftUI
import MQLCoreUI

/// A SwiftUI view for the theme switcher.
struct ThemeSwitcherView: View {
    /// The theme environment object for styling.
    @EnvironmentObject var theme : Theme
    
    /// selected color scheme
    @State var selectedColorScheme: String = "system"
        
        //
        @Environment(\.colorScheme) var deviceColorScheme: ColorScheme
    
    /// The body of the view.
    var body: some View {
        SettingsTitleView(title: "app".localized())
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Image(systemName: "moonphase.first.quarter")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 10)
                        .padding(.leading, 2)
                        .foregroundColor(theme.colors.secondary)
                    
                    Text("theme".localized())
                        .font(theme.typography.body1)
                        .foregroundColor(theme.colors.secondary)
                    
                }
                
                Picker("theme".localized(), selection: $selectedColorScheme) {
                    Text("system".localized()).tag("system")
                    Text("dark".localized()).tag("dark")
                    Text("light".localized()).tag("light")
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedColorScheme) { newScheme in
                    print("new scheme: \(newScheme)")
                }
            }
            .padding(8)
        }
        .background(theme.colors.backGroundPrimary)
        .cornerRadius(8)
        .preferredColorScheme(getPreferredColorScheme())
    }
    
    /**
       Retrieves the preferred color scheme based on the selected color scheme.

       - Returns: A `ColorScheme` enum value representing the preferred color scheme, or `nil` if no valid color scheme is selected.

       - Note: The color schemes include `.light` and `.dark`.
    */
    private func getPreferredColorScheme() -> ColorScheme? {
        switch selectedColorScheme {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
}

#Preview {
    ThemeSwitcherView()
}
