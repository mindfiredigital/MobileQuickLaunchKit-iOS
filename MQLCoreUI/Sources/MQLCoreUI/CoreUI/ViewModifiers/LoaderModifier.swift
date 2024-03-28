//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 18/12/23.
//

import SwiftUI

/**
 A view modifier that displays a loader when a task is in progress.
 */
struct LoaderModifier: ViewModifier {
    /// A binding to indicate whether the loader is currently active.
    @Binding var isLoading: Bool
    
    /**
     Modifies the appearance of the view.
     
     - Parameter content: The content of the view.
     - Returns: A modified view.
     */
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
    /**
     Generates a loader to indicate that a task is currently in progress.
     
     - Parameter isLoading: A binding that indicates whether the loader should be displayed.
     - Returns: A modified view.
     */
    public func loader(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
