//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

public struct SecureTextFieldModifier: ViewModifier {
    var icon: Image?
    var placeholderName: String = ""
    @Binding var text: String
    @Binding var error: String?
    @Binding var isSecure: Bool
    @EnvironmentObject var theme: Theme

    public func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Text Field Left Icon
                if let icon = icon {
                    icon
                        .foregroundColor(theme.colors.borderColor)
                }
                
                if isSecure {
                    SecureField("", text: $text)
                        .autocapitalization(.none)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholderName).foregroundColor(theme.colors.placeholderText)
                        }
                        .foregroundColor(theme.colors.secondary)
                } else {
                    TextField(placeholderName, text: $text)
                        .autocapitalization(.none)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholderName)
                                .foregroundColor(theme.colors.placeholderText)
                        }
                        .foregroundColor(theme.colors.secondary)
                }
                
                //Eye icon button
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
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
                Text(error)
                    .foregroundColor(theme.colors.error)
                    .font(theme.typography.body1)
            }
        }
       
    }
}

extension View {
    public func SecureTextField(icon: Image?, text: Binding<String>, isSecure: Binding<Bool>,placeholderName: String,error: Binding<String?>) -> some View {
        self.modifier(SecureTextFieldModifier(icon: icon, placeholderName: placeholderName, text: text, error: error, isSecure: isSecure))
    }
}
