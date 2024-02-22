//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import SwiftUI

extension View {
    
    /// This function is used to show the alert on top of the view
    public func showAlert(title: String, isPresented: Binding<Bool>, message: String, dismissButtonTitle: String = "OK", onDismiss: (() -> Void)? = nil) -> some View {
          self.alert(isPresented: isPresented) {
              Alert(
                title: Text(title),
                  message: Text(message),
                  dismissButton: .default(Text(dismissButtonTitle), action: {
                      onDismiss?()
                  })
              )
          }
      }
    
    ////// This function is used to show the alert with two button on top of the view
    public func showAlertWithTwoButtons(title: String, isPresented: Binding<Bool>, message: String, primaryButtonTitle: String, secondaryButtonTitle: String, onPrimaryButtonTapped: (() -> Void)? = nil, onSecondaryButtonTapped: (() -> Void)? = nil) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .default(Text(primaryButtonTitle), action: {
                    onPrimaryButtonTapped?()
                }),
                secondaryButton: .cancel(Text(secondaryButtonTitle), action: {
                    onSecondaryButtonTapped?()
                })
            )
        }
    }
    
    public func showToast(message: String, isPresented: Binding<Bool>) -> some View {
        self.modifier(ToastModifier(message: message, isPresented: isPresented))
    }
    
}

struct ToastModifier : ViewModifier {
    let message: String
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ToastView(message: message, showToast: $isPresented)
            }
        }
    }
}

struct ToastView: View {
    @EnvironmentObject var theme: Theme
    
    var message: String
    @Binding var showToast: Bool

    var body: some View {
        ZStack {
            if showToast {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(theme.colors.backGroundSecondary)
                    .frame(width: 250, height: 70)
                    .overlay(
                        Text(message)
                            .foregroundColor(theme.colors.secondary)
                            .padding(10)
                            .font(theme.typography.h3)
                    )
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: 0.5))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                showToast = false
                            }
                        }
                    }
            }
        }
    }
}
