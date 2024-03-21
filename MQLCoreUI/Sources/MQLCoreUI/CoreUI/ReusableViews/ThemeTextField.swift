//
//  SwiftUIView.swift
//  
//
//  Created by Hemant Sudhanshu on 08/01/24.
//

import SwiftUI

/**
 A custom text field with a themed appearance.
 */
public struct ThemeTextField: View {
    /// The placeholder text for the text field.
    var placeholderText: String
    
    /// The optional icon to display alongside the text field.
    var icon: Image?
    
    /// The type of keyboard to display when editing the text field.
    var keyBoardType: UIKeyboardType
    
    /// The text binding for the text field.
    @Binding var text: String
    
    /// The optional error message binding for the text field.
    @Binding var error: String?
    
    /// The environment object providing the theme settings.
    @EnvironmentObject var theme: Theme
    
    /// A boolean value indicating whether the text field is for entering a phone number.
    var isPhoneField: Bool
    
    /**
     Initializes the ThemeTextField view.
     
     - Parameters:
     - placeholderText: The placeholder text for the text field.
     - icon: The optional icon to display alongside the text field.
     - keyBoardType: The type of keyboard to display when editing the text field.
     - text: The text binding for the text field.
     - error: The optional error message binding for the text field.
     - isPhoneField: A boolean value indicating whether the text field is for entering a phone number.
     */
    public init(placeholderText: String, icon: Image? = nil, keyBoardType: UIKeyboardType = .default, text: Binding<String>, error: Binding<String?>, isPhoneField: Bool = false) {
        self.placeholderText = placeholderText
        self.icon = icon
        self.keyBoardType = keyBoardType
        self._text = text
        self._error = error
        self.isPhoneField = isPhoneField
    }
    
    public var body: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text(placeholderText).foregroundColor(theme.colors.placeholderText)
            }
            .textFieldModifier(icon: icon, text: $text, error: $error)
            .keyboardType(keyBoardType)
            .onChange(of: text) { _ in
                if isPhoneField {
                    text = String(text.prefix(13))
                }
            }
    }
}

