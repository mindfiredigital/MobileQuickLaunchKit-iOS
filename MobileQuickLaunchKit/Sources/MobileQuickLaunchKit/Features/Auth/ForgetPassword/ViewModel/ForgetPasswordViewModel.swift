//
//  File.swift
//
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation
import MQLCore

final class ForgetPasswordViewModel: ObservableObject {
    @Published var forgetPasswordEventHandler:((_ event: ForgetPasswordEvents<ForgetPasswordResponse>) -> Void)?
    
    @Published var isOTPVerificationModalPresented = false
    
    @Published var isActive: Bool = false
    @Published var isAlertPresented = false
    @Published var alertMessage: String?
    @Published var isLoading = false
    
    @Published var emailTextField: String = ""
    @Published var emailError: String?
    
    /// This func is used to request forgotPassword api
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
    
    //MARK: - Private func
    
    ///This func is used to observe forgetPassword api events
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
