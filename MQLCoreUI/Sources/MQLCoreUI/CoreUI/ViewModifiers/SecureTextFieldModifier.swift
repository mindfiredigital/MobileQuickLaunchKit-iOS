//
//  File.swift
//
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

/**
 A view modifier that customizes a secure text field with an optional icon, placeholder, and error message.
 */
public struct SecureTextFieldModifier: ViewModifier {
    /// An optional icon for the secure text field.
    var icon: Image?
    /// The placeholder text for the secure text field.
    var placeholderName: String = ""
    /// A binding to the text entered in the secure text field.
    @Binding var text: String
    /// A binding to indicate whether the text entered is secure.
    @Binding var error: String?
    /// The theme object providing color and font properties.
    @Binding var isSecure: Bool
    /// A binding to the error message associated with the secure text field.
    @EnvironmentObject var theme: Theme
    
    /**
     Modifies the appearance of the view.
     
     - Parameter content: The content of the view.
     - Returns: A modified view.
     */
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
    /**
     Produces a customized secure text field complete with an icon, border, and rounded corners.
     
     - Parameters:
     - icon: An optional image to be displayed as an icon.
     - text: A binding to the text entered in the secure text field.
     - isSecure: A binding to indicate whether the entered text is secure.
     - placeholderName: The placeholder text for the secure text field.
     - error: A binding to the error message associated with the secure text field.
     - Returns: A modified view with the secure text field customization.
     */
    public func SecureTextField(icon: Image?, text: Binding<String>, isSecure: Binding<Bool>,placeholderName: String,error: Binding<String?>) -> some View {
        self.modifier(SecureTextFieldModifier(icon: icon, placeholderName: placeholderName, text: text, error: error, isSecure: isSecure))
    }
}
