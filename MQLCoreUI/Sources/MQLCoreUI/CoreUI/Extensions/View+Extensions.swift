//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import SwiftUI

/**
 An extension providing utility methods for displaying alerts and toast messages on top of views.
 */
extension View {
    
    /**
     Displays an alert with a single dismiss button.
     
     - Parameters:
     - title: The title of the alert.
     - isPresented: A binding to a Boolean value that determines whether the alert is shown.
     - message: The message to display in the alert.
     - dismissButtonTitle: The title of the dismiss button.
     - onDismiss: An optional closure to be executed when the alert is dismissed.
     */
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
    
    /**
     Displays an alert with two buttons: a primary and a secondary button.
     
     - Parameters:
     - title: The title of the alert.
     - isPresented: A binding to a Boolean value that determines whether the alert is shown.
     - message: The message to display in the alert.
     - primaryButtonTitle: The title of the primary button.
     - secondaryButtonTitle: The title of the secondary button.
     - onPrimaryButtonTapped: An optional closure to be executed when the primary button is tapped.
     - onSecondaryButtonTapped: An optional closure to be executed when the secondary button is tapped.
     */
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
    
    /**
     Displays a toast message on top of the view.
     
     - Parameters:
     - message: The message to display in the toast.
     - isPresented: A binding to a Boolean value that determines whether the toast is shown.
     */
    public func showToast(message: String, isPresented: Binding<Bool>) -> some View {
        self.modifier(ToastModifier(message: message, isPresented: isPresented))
    }
    
}

/**
 A view modifier to show a toast message.
 */
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


/**
 A view for displaying a toast message.
 */
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
