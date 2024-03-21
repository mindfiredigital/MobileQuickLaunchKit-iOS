//
//  File.swift
//
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation
import MQLCore

/**
 View model for setting a new password.
 
 This class manages the state and logic related to setting a new password in the application.
 
 Usage:
 let viewModel = SetNewPasswordViewModel()
 viewModel.resetPassword(password: "newPassword", confirmPassword: "newPassword")
 
 - Note: This class relies on `SetPasswordEvents` for event handling and `SetNewPasswordResponse` for response data.
 
 - Important: Before using this class, ensure that the `MQLBaseService` is properly configured to handle API requests.
 */
final class SetNewPasswordViewModel: ObservableObject {
    
    /// Closure property to handle set password events.
    @Published var setPasswordEventHandler:((_ event: SetPasswordEvents<SetNewPasswordResponse>) -> Void)?
    
    /// State for presenting alerts.
    @Published var isAlertPresented = false
    
    /// Alert message to display.
    @Published var alertMessage: String?
    
    /// State for indicating loading state.
    @Published var isLoading = false
    
    /// Text for entering the new password.
    @Published var passwordTextField: String = ""
    
    /// Error message for password validation.
    @Published var passwordError: String?
    
    /// Text for confirming the new password.
    @Published var confirmPasswordTextField: String = ""
    
    /// Error message for confirming password validation.
    @Published var confirmPasswordError: String?
    
    /// State for indicating whether the password is secure.
    @Published var isSecurePassword: Bool = true
    
    /// State for indicating whether the confirm password is secure.
    @Published var isSecureConfirmPassword: Bool = true
    
    /**
     Resets the password with the provided new password and confirmation.
     
     - Parameters:
        - password: The new password.
        - confirmPassword: The confirmation of the new password.
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
     Observes reset password state and handles related events.
     
     - Parameter isModalPresented: Closure to be executed upon successful password reset.
     */
    func observeResetPasswordState(isModalPresented: @escaping () -> Void) {
        self.setPasswordEventHandler = { setPasswordEvent in
            
            DispatchQueue.main.async {
                
                switch setPasswordEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.passwordError = nil
                    self.confirmPasswordError = nil
                    
                case .success(response: _):
                    isModalPresented()
                    self.isLoading = false
                    
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
