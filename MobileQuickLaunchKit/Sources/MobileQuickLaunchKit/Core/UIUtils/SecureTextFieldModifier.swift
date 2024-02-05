//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

public struct SecureTextFieldModifier: ViewModifier {
    var iconName: String?
    var placeholderName: String = ""
    @Binding var text: String
    @Binding var error: String?
    @Binding var isSecure: Bool
    @EnvironmentObject var theme: Theme

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Text Field Left Icon
                if let iconName = iconName {
                    Image(iconName, bundle: .module)
                        .foregroundColor(theme.colors.borderColor)
                }
                
                if isSecure {
                    SecureField(NSLocalizedString("", bundle: .module, comment: ""), text: $text)
                        .autocapitalization(.none)
                        .placeholder(when: text.isEmpty) {
                            Text(NSLocalizedString(placeholderName,bundle: .module, comment: "")).foregroundColor(theme.colors.placeholderText)
                        }
                        .foregroundColor(theme.colors.secondary)
                } else {
                    TextField(NSLocalizedString(placeholderName, bundle: .module, comment: ""), text: $text)
                        .autocapitalization(.none)
                        .placeholder(when: text.isEmpty) {
                            Text(NSLocalizedString(placeholderName,bundle: .module, comment: "")).foregroundColor(theme.colors.placeholderText)
                        }
                        .foregroundColor(theme.colors.secondary)
                }
                
                //Eye icon button
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? Icon.eyeClose : Icon.eye)
                        .foregroundColor(theme.colors.tertiary)
                        .padding(.trailing, 8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .font(theme.typography.body1)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 2).foregroundColor(theme.colors.borderColor))
            
            // Text Field error text
            if let error = error, !error.isEmpty {
                Text(NSLocalizedString(error, bundle: .module, comment: ""))
                    .foregroundColor(theme.colors.error)
                    .font(theme.typography.body1)
            }
        }
       
    }
}

extension View {
    func SecureTextField(iconName: String?, text: Binding<String>, isSecure: Binding<Bool>,placeholderName: String,error: Binding<String?>) -> some View {
        self.modifier(SecureTextFieldModifier(iconName: iconName,placeholderName: placeholderName, text: text, error: error, isSecure: isSecure))
    }
}
