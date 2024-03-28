//
//  File.swift
//
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation
import MQLCore

/// View model for handling forget password functionality.
final class ForgetPasswordViewModel: ObservableObject {
    /// Closure property to handle forget password events.
    @Published var forgetPasswordEventHandler: ((_ event: ForgetPasswordEvents<ForgetPasswordResponse>) -> Void)?
    
    /// State for presenting OTP verification modal.
    @Published var isOTPVerificationModalPresented = false
    
    /// State indicating whether the view model is active.
    @Published var isActive: Bool = false
    
    /// State for presenting alerts.
    @Published var isAlertPresented = false
    
    /// Alert message to display.
    @Published var alertMessage: String?
    
    /// State for indicating loading state.
    @Published var isLoading = false
    
    /// Text field for user's email.
    @Published var emailTextField: String = ""
    
    /// Error message for email validation.
    @Published var emailError: String?
    
    /**
     Sends request to send OTP for forget password.
     
     - Parameter email: The user's email address.
     */
    func sendOTP(email: String) {
        self.forgetPasswordEventHandler?(.loading)
        
        if !MQLValidations.isValidEmail(email: email) {
            self.forgetPasswordEventHandler?(.emailValidationError(error: "invalidEmail"))
            return
        }
        let parameter: [String : String] = [
            APIBodyVariables.email : email.lowercased(),
        ]
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.forgetPassword(data: parameter)) { (result: Result<ForgetPasswordResponse, APIError>)  in
            switch result {
                
            case .success(let response):
                self.forgetPasswordEventHandler?(.success(response: response))
            case .failure(let error):
                self.forgetPasswordEventHandler?(.error(error: error))
                
            }
        }
    }
    
    /**
     Observes forget password state and handles related events.
     */
    func observeForgetPasswordState() {
        
        self.forgetPasswordEventHandler = {  forgetPasswordEvent in
            DispatchQueue.main.async {
                
                switch forgetPasswordEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.emailError = nil
                    
                case .success(response: _):
                    self.isOTPVerificationModalPresented.toggle()
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
                    
                case .emailValidationError(error: let error):
                    self.emailError = error.localized()
                    self.isLoading = false
                }
                
            }
        }
    }
}
