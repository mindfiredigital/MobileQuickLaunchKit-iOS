//
//  SwiftUIView.swift
//  
//
//  Created by Hemant Sudhanshu on 08/01/24.
//

import SwiftUI

public struct ThemeTextField: View {
    var placeholderText: String
    var icon: Image?
    var keyBoardType: UIKeyboardType
    @Binding var text: String
    @Binding var error: String?
    @EnvironmentObject var theme : Theme
    var isPhoneField: Bool
    
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

//#Preview {
//    ThemeTextField(placeholderText: "Placeholder", text: "", error: "")
//}
