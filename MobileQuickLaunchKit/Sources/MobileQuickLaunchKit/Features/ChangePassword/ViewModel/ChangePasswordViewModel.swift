//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 08/01/24.
//

import Foundation
import MQLCore


final class ChangePasswordViewModel: ObservableObject {
    
    @Published var setPasswordEventHandler:((_ event: SetPasswordEvents<SetNewPasswordResponse>) -> Void)?
    
    @Published var isAlertPresented = false
    @Published var alertMessage: String?
    @Published var isLoading = false
    
    @Published var passwordTextField: String = ""
    @Published var passwordError: String?
    
    @Published var confirmPasswordTextField: String = ""
    @Published var confirmPasswordError: String?
    
    @Published var isSecurePassword: Bool = true
    @Published var isSecureConfirmPassword: Bool = true
    
    /// This method is used to set new password in the app.
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
    
    ///This func is used to observe reset password api events
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
