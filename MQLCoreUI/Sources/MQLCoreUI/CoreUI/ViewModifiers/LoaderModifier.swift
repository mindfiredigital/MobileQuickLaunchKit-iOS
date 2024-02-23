//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 18/12/23.
//

import SwiftUI

struct LoaderModifier: ViewModifier {
    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isLoading ? 2 : 0)
                .disabled(isLoading)

            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.5).ignoresSafeArea())
            }
        }
    }
}

extension View {
    public func loader(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
