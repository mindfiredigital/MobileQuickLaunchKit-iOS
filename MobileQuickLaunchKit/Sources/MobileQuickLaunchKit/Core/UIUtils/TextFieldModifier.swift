//
//  File.swift
//
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI


struct TextFieldModifier: ViewModifier {
    var iconName: String?
    @Binding var text: String
    @Binding var error: String?
    @EnvironmentObject var theme : Theme
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Text Field Left Icon
                if let iconName = iconName {
                    Image(iconName, bundle: .module)
                        .foregroundColor(theme.colors.borderColor)
                }
                content
                    .font(theme.typography.body1)
                    .foregroundColor(theme.colors.secondary)
            }
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(theme.colors.borderColor))
            .autocapitalization(.none)
        }
        
        // Text Field error text
        if let error = error, !error.isEmpty {
            Text(NSLocalizedString(error, bundle: .module, comment: ""))
                .foregroundColor(theme.colors.error)
                .font(theme.typography.body1)
        }
    }
}

extension View {
    func textField(iconName: String?, text: Binding<String>, error: Binding<String?>) -> some View {
        self.modifier(TextFieldModifier(iconName: iconName, text: text, error: error))
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
