//
//  SwiftUIView.swift
//  
//
//  Created by Hemant Sudhanshu on 08/01/24.
//

import SwiftUI

public struct ThemeTextField: View {
    var placeholderText: String
    var iconName: String?
    var keyBoardType: UIKeyboardType = .default
    @Binding var text: String
    @Binding var error: String?
    @EnvironmentObject var theme : Theme
    var isPhoneField = false
    
    public var body: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text(NSLocalizedString(placeholderText,bundle: .module, comment: "")).foregroundColor(theme.colors.placeholderText)
            }
            .textField(iconName: iconName, text: $text, error: $error)
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
