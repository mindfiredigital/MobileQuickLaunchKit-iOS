//
//  File.swift
//
//
//  Created by Satyam Tripathi on 14/12/23.
//

import Foundation
import SwiftUI

/**
 A view modifier that customizes the appearance of a text field, including an optional icon, border, and error text.
 */
struct TextFieldModifier: ViewModifier {
    /// The optional icon displayed on the left side of the text field.
    var icon: Image?
    /// The text binding representing the text input.
    @Binding var text: String
    /// The binding representing any error associated with the text field.
    @Binding var error: String?
    /// The theme object to customize the appearance.
    @EnvironmentObject var theme : Theme
    
    /**
     Modifies the appearance of the view.
     
     - Parameter content: The content of the view.
     - Returns: A modified view.
     */
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
    /**
     Produces a customized TextField complete with an icon, border, and rounded corners.
     
     - Parameters:
     - icon: The optional icon to display on the left side of the text field.
     - text: The binding representing the text input.
     - error: The binding representing any error associated with the text field.
     - Returns: A modified view.
     */
    public func textFieldModifier(icon: Image?, text: Binding<String>, error: Binding<String?>) -> some View {
        self.modifier(TextFieldModifier(icon: icon, text: text, error: error))
    }
    
    /**
     Assigns a placeholder to a TextField.
     
     - Parameters:
     - shouldShow: A boolean indicating whether the placeholder should be displayed.
     - alignment: The alignment of the placeholder.
     - placeholder: The content of the placeholder.
     - Returns: A view with a placeholder assigned to the TextField.
     */
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
