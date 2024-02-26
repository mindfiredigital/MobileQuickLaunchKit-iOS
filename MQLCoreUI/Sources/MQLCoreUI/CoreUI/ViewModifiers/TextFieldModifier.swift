//
//  File.swift
//
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI


struct TextFieldModifier: ViewModifier {
    var icon: Image?
    @Binding var text: String
    @Binding var error: String?
    @EnvironmentObject var theme : Theme
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Text Field Left Icon
                if let icon = icon {
                    icon
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
            Text(error)
                .foregroundColor(theme.colors.error)
                .font(theme.typography.body1)
        }
    }
}

extension View {
    public func textFieldModifier(icon: Image?, text: Binding<String>, error: Binding<String?>) -> some View {
        self.modifier(TextFieldModifier(icon: icon, text: text, error: error))
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
