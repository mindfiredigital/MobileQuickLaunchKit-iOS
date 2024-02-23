//
//  File.swift
//
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import MQLCore

final class SignUpViewModel: ObservableObject {
    
    @Published var signUpEventHandler:((_ event: SignUpEvents) -> Void)?
    @Published var isLoggedIn = false
    @Published var isAlertPresented = false
    @Published var alertMessage: String?
    @Published var isLoading = false
    
    @Published var fullnameTextField: String = ""
    @Published var fullnameError: String?
    
    @Published var emailTextField: String = ""
    @Published var emailError: String?
    
    @Published var passwordTextField: String = ""
    @Published var passwordError: String?
    
    @Published var confirmPasswordTextField: String = ""
    @Published var confirmPasswordError: String?
    
    @Published var isSecurePassword: Bool = true
    @Published var isSecureConfirmPassword: Bool = true
    
    /// This method is used to sign up in the app.
    func signUp(fullname: String, email: String, password: String, confirmPassword: String){
        self.signUpEventHandler?(.loading)
        var hasValidationError: Bool = false
        if fullname.count < 3 {
            self.signUpEventHandler?(.fullnameValidationError(error: "invalidFullname"))
        }
        
        if !MQLValidations.isValidEmail(email: email) {
            self.signUpEventHandler?(.emailValidationError(error: "invalidEmail"))
            hasValidationError = true
        }
        if !MQLValidations.isStrongPassword(password: password) {
            self.signUpEventHandler?(.passwordValidationError(error: "invalidPassword"))
            hasValidationError = true
        }
        if password != confirmPassword {
            self.signUpEventHandler?(.confirmPasswordValidationError(error: "invalidConfirmPassword"))
            hasValidationError = true
        }
        if hasValidationError {
            return
        }
        
        let parameter: [String : String] = [
            APIBodyVariables.fullName: fullname,
            APIBodyVariables.email : email,
            APIBodyVariables.password : password,
            APIBodyVariables.confirmPassword : confirmPassword
        ]
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.signUp(data: parameter)) { (result: Result<SignUpResponse, APIError>)  in
            switch result {
                
            case .success(let response):
                //Save email, password and token to local storage
                SecureUserDefaults.setValue(email, forKey: LocalStorageKeys.emailOrUsername)
                SecureUserDefaults.setValue(password, forKey: LocalStorageKeys.password)
                SecureUserDefaults.setValue(response.data.token, forKey: LocalStorageKeys.token)
                MQLAppState.shared.setValues()
                self.signUpEventHandler?(.success(response: response))
            case .failure(let error):
                self.signUpEventHandler?(.error(error: error))
                
            }
        }
        
    }
    
    ///This func is used to observe sign up api events
    func observeSignUpState(onSuccess: @escaping() -> Void ) {
        self.signUpEventHandler = {  signUpEvent in
            
            DispatchQueue.main.async {
                switch signUpEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.fullnameError = nil
                    self.emailError = nil
                    self.passwordError = nil
                    self.confirmPasswordError = nil
                    
                case .success(response: _):
                    self.isLoading = false
                    onSuccess()
                    
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
                    
                case .passwordValidationError(error: let error):
                    self.passwordError = error.localized()
                    self.isLoading = false
                    
                case .fullnameValidationError(error: let error):
                    self.fullnameError = error.localized()
                    self.isLoading = false
                    
                case .confirmPasswordValidationError(error: let error):
                    self.confirmPasswordError = error.localized()
                    self.isLoading = false
                }
            }
        }
    }
}
