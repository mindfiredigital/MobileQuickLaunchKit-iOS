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
                title: Text(NSLocalizedString(title, bundle: .module, comment: "")),
                  message: Text(NSLocalizedString(message, bundle: .module, comment: "")),
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
                title: Text(NSLocalizedString(title, bundle: .module, comment: "")),
                message: Text(NSLocalizedString(message, bundle: .module, comment: "")),
                primaryButton: .default(Text(primaryButtonTitle), action: {
                    onPrimaryButtonTapped?()
                }),
                secondaryButton: .cancel(Text(secondaryButtonTitle), action: {
                    onSecondaryButtonTapped?()
                })
            )
        }
    }
}
