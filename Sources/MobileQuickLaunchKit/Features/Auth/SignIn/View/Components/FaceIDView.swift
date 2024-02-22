//
//  SwiftUIView.swift
//  
//
//  Created by Satyam Tripathi on 22/12/23.
//

import SwiftUI
import MQLCoreUI

struct FaceIDView: View {
    
    @EnvironmentObject var theme : Theme
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: Icon.faceId)
                .font(.system(size: 40))
                .foregroundColor(theme.colors.tertiary)
            Text("signInWithFaceId", bundle: .module)
                .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                .padding(.top, 5)
            Text("signInWithFaceIdMsg", bundle: .module)
                .frame(width: 200)
                .multilineTextAlignment(.center)
                .modifier(theme.typography.body1Style(color: theme.colors.secondary))
                .padding(.top, 5)
        }
        .padding(.vertical, 15)
        .background(RoundedRectangle(cornerRadius: 10).fill(theme.colors.backGroundSecondary))
        .shadow(color: Color.gray.opacity(0.1), radius: 4, x: 2, y: 2)
    }
}
