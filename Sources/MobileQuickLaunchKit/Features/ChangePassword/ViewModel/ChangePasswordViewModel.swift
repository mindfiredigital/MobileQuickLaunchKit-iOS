//
//  File.swift
//
//
//  Created by Satyam Tripathi on 08/01/24.
//

import Foundation
import MQLCore

/**
 View model for managing the process of changing the user's password.
 
 This view model handles the logic and state related to changing the user's password, including password validation and API communication.
 */
final class ChangePasswordViewModel: ObservableObject {
    
    /// Closure to handle password change events.
    @Published var setPasswordEventHandler:((_ event: SetPasswordEvents<SetNewPasswordResponse>) -> Void)?
    
    /// Indicates whether an alert is presented.
    @Published var isAlertPresented = false
    
    /// Message to be displayed in the alert.
    @Published var alertMessage: String?
    
    /// Indicates whether data is loading.
    @Published var isLoading = false
    
    /// The user's new password entered in the text field.
    @Published var passwordTextField: String = ""
    
    /// Error message for password validation.
    @Published var passwordError: String?
    
    /// The confirmation of the new password entered in the text field.
    @Published var confirmPasswordTextField: String = ""
    
    /// Error message for password confirmation validation.
    @Published var confirmPasswordError: String?
    
    /// Indicates whether the password text field is secure (masked).
    @Published var isSecurePassword: Bool = true
    
    /// Indicates whether the confirm password text field is secure (masked).
    @Published var isSecureConfirmPassword: Bool = true
    
    /**
     Resets the user's password.
     
     - Parameters:
     - password: The new password to be set.
     - confirmPassword: The confirmation of the new password.
     
     - Note: This method initiates the process of changing the user's password by validating the passwords and making an API request to update the password.
     
     - Important: This method relies on the `MQLBaseService` to make the API request and `MQLValidations` for password validation.
     */
    func resetPassword(password: String, confirmPassword: String){
        self.setPasswordEventHandler?(.loading)
        var hasValidationError: Bool = false
        
        if !MQLValidations.isStrongPassword(password: password) {
            self.setPasswordEventHandler?(.passwordValidationError(error: "invalidPassword"))
            hasValidationError = true
        }
        if password != confirmPassword {
            self.setPasswordEventHandler?(.confirmPasswordValidationError(error: "invalidConfirmPassword"))
            hasValidationError = true
        }
        if hasValidationError {
            return
        }
        
        let parameters:[String : String] = [APIBodyVariables.password : password,
                                            APIBodyVariables.confirmPassword : confirmPassword]
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.resetPassword(data: parameters)) { (result: Result<SetNewPasswordResponse, APIError>)  in
            switch result {
                
            case .success(let response):
                self.setPasswordEventHandler?(.success(response: response))
            case .failure(let error):
                self.setPasswordEventHandler?(.error(error: error))
                
            }
        }
        
    }
    
    /**
     Observes the reset password state.
     
     This method observes the state changes during the process of resetting the password and updates the view accordingly.
     
     - Note: This method updates the `isLoading`, `passwordError`, `confirmPasswordError`, `alertMessage`, and `isAlertPresented` properties based on the password change events.
     
     */
    func observeResetPasswordState() {
        self.setPasswordEventHandler = { setPasswordEvent in
            
            DispatchQueue.main.async {
                
                switch setPasswordEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.passwordError = nil
                    self.confirmPasswordError = nil
                    
                case .success(response: _):
                    self.alertMessage = "passwordChangedMsg"
                    self.isLoading = false
                    self.isAlertPresented = true
                    
                case .error(error: let error):
                    switch error {
                        
                    case .connectivity(error: let error):
                        self.alertMessage = error
                        
                    case .network(error: let error):
                        self.alertMessage = error.message
                        
                    default:
                        self.alertMessage = "somethingWentWrong"
                    }
                    self.isLoading = false
                    self.isAlertPresented = true
                    
                case .passwordValidationError(error: let error):
                    self.passwordError = error.localized()
                    self.isLoading = false
                    
                case .confirmPasswordValidationError(error: let error):
                    self.confirmPasswordError = error.localized()
                    self.isLoading = false
                }
                
            }
        }
    }
    
}
