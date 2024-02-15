//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI
import MQLCoreUI

struct BottomSignUpView: View {
    
    @Binding var isSignUpModalPresented: Bool
    @EnvironmentObject var theme : Theme
    
    var body: some View {
        HStack{
            Text("dontHaveAccount", bundle: .module)
                .modifier(theme.typography.body1Style(color: theme.colors.secondary))
            
            Button("signUp".localized()) {
                isSignUpModalPresented.toggle()
            }
            .font(theme.typography.h4)
            .foregroundColor(theme.colors.primary)
        }
        .padding(.bottom, 15)
        .frame(maxWidth: .infinity)
    }
}
