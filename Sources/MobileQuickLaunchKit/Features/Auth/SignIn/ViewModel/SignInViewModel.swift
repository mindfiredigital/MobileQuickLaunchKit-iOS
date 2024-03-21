//
//  File.swift
//
//
//  Created by Satyam Tripathi on 12/12/23.
//

import Foundation
import LocalAuthentication
import GoogleSignIn
import AuthenticationServices
import CryptoKit
import MQLCore

/// View model for handling sign-in functionality.
final class SignInViewModel: NSObject, ObservableObject {
    
    // MARK: - Published Properties
    
    /// Closure property to handle sign-in events.
    @Published var signInEventHandler: ((_ event: SignInEvents) -> Void)?
    
    /// State for presenting sign-up modal.
    @Published var isSignUpModalPresented = false
    
    /// State for presenting forgot password modal.
    @Published var isForgetPasswordModalPresented = false
    
    /// Text field for user's email or username.
    @Published var emailTextField: String = ""
    
    /// Error message for username validation.
    @Published var usernameError: String?
    
    /// Text field for user's password.
    @Published var passwordTextField: String = ""
    
    /// Error message for password validation.
    @Published var passwordError: String?
    
    /// State for presenting alerts.
    @Published var isAlertPresented = false
    
    /// Alert message to display.
    @Published var alertMessage: String?
    
    /// State for indicating loading state.
    @Published var isLoading = false
    
    /// State for password secure entry.
    @Published var isSecure: Bool = true
    
    /// Closure property for handling Google sign-in events.
    var googleSignInEventHandler: ((_ event: SocialSignInEvents) -> Void)?
    
    /// Closure property for handling Apple sign-in events.
    var appleSignInEventHandler: ((_ event: SocialSignInEvents) -> Void)?
    
    // MARK: - Private Properties
    
    /// Unhashed nonce for Apple sign-in.
    fileprivate var currentNonce: String?
    
    // MARK: - Sign-In Methods
    
    /**
     Attempts to log in the user with provided credentials.
     
     - Parameters:
     - emailOrUsername: The user's email or username.
     - password: The user's password.
     */
    func login(emailOrUsername: String, password: String){
        self.signInEventHandler?(.loading)
        
        var hasValidationError: Bool = false
        if !MQLValidations.isValidEmail(email: emailOrUsername) {
            self.signInEventHandler?(.emailValidationError(error: "invalidEmailOrUsername"))
            hasValidationError = true
        }
        if !MQLValidations.isStrongPassword(password: password) {
            self.signInEventHandler?(.passwordValidationError(error: "invalidPassword"))
            hasValidationError = true
        }
        
        if hasValidationError {
            return
        }
        
        let parameters:[String : String] = [APIBodyVariables.email : emailOrUsername.lowercased(),
                                            APIBodyVariables.password : password]
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.login(data: parameters)) { (result: Result<LoginResponse, APIError>)  in
            switch result {
                
            case .success(let response):
                //Save email, password and token to local storage
                SecureUserDefaults.setValue(emailOrUsername, forKey: LocalStorageKeys.emailOrUsername)
                SecureUserDefaults.setValue(password, forKey: LocalStorageKeys.password)
                SecureUserDefaults.setValue(response.data.token, forKey: LocalStorageKeys.token)
                MQLAppState.shared.setValues()
                self.signInEventHandler?(.success(response: response))
            case .failure(let error):
                self.signInEventHandler?(.error(error: error))
                
            }
        }
    }
    
    /**
     Observes sign-in state and executes a closure when modal is presented.
     
     - Parameters:
     - isModalPresented: Closure to be executed when modal is presented.
     */
    func observeSignInState(isModalPresented: @escaping () -> Void) {
        self.signInEventHandler = {  signInEvent in
            
            DispatchQueue.main.async {
                switch signInEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.usernameError = nil
                    self.passwordError = nil
                    
                case .success(response: _):
                    self.isLoading = false
                    // Close the login model and go to the home screen
                    isModalPresented()
                    
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
                    self.usernameError = error.localized()
                    self.isLoading = false
                    
                case .passwordValidationError(error: let error):
                    self.passwordError = error.localized()
                    self.isLoading = false
                }
            }
        }
    }
    
    /**
     Initiates face ID authentication.
     */
    func faceIdAuthentication(){
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            debugPrint(error?.localizedDescription ?? DebugPrints.faceIDPolicyError)
            // Fall back to a asking for username and password.
            // ...
            return
        }
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "faceIDReason".localized())
                guard let email = MQLAppState.shared.email else {return}
                guard let password = MQLAppState.shared.password else {return}
                login(emailOrUsername: email, password: password)
            } catch let error {
                debugPrint(error.localizedDescription)
                // Fall back to a asking for username and password.
                // ...
            }
        }
    }
    
    /**
     Initiates sign-in with Google.
     */
    func signInWithGoogle() {
        
        self.googleSignInEventHandler?(.loading)
        // Check the internet connectivity
        if(!Connectivity.isConnectedToInternet){
            self.googleSignInEventHandler?(.connectivityError(error: "noInternetConnection"))
            return
        }
        
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
                guard error == nil else {
                    print(error?.localizedDescription as Any)
                    self.googleSignInEventHandler?(.error(error: error))
                    return
                }
                //Call Google Signup/SignIn api
                guard let accessToken = result?.user.accessToken.tokenString else {
                    print(error?.localizedDescription as Any)
                    self.googleSignInEventHandler?(.error(error: error))
                    return
                }
                
                debugPrint(accessToken)
                
                
                MQLBaseService.shared.request(endpoint: MQLEndpoint.socialSignUp(data: [APIBodyVariables.token : accessToken])) { (result: Result<LoginResponse, APIError>)  in
                    switch result {
                    case .success(let response):
                        // Delete stored email and password from local storage
                        SecureUserDefaults.removeValue(forKey: LocalStorageKeys.emailOrUsername)
                        SecureUserDefaults.removeValue(forKey: LocalStorageKeys.password)
                        MQLAppState.shared.email = nil
                        MQLAppState.shared.password = nil
                        // Save token to local storage
                        SecureUserDefaults.setValue(response.data.token, forKey: LocalStorageKeys.token)
                        MQLAppState.shared.setValues()
                        self.googleSignInEventHandler?(.success)
                    case .failure(let error):
                        self.googleSignInEventHandler?(.error(error: error))
                    }
                }
            }
            
            
        }
    }
    
    /**
     Observes Google sign-up events and executes a closure when modal is presented.
     
     - Parameters:
     - isModalPresented: Closure to be executed when modal is presented.
     */
    func observeGoogleSignupEvents(isModalPresented: @escaping () -> Void) {
        self.googleSignInEventHandler = { googleSignInEvent in
            
            DispatchQueue.main.async {
                
                switch googleSignInEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.usernameError = nil
                    self.passwordError = nil
                    
                case .success:
                    self.isLoading = false
                    // Close the login model and go to the home screen
                    isModalPresented()
                    
                case .error(error: let error):
                    self.alertMessage = error?.localizedDescription
                    self.isLoading = false
                    self.isAlertPresented = true
                    
                case .connectivityError(error: let error):
                    self.alertMessage = error
                    self.isLoading = false
                    self.isAlertPresented = true
                }
            }
        }
    }
    
    /**
     Stores Apple email and full name in local storage.
     
     - Parameters:
     - appleIDCredential: Apple ID credential containing email and full name.
     */
    func storeAppleEmailAndFullName(appleIDCredential: ASAuthorizationAppleIDCredential) {
        // Save apple id email to keychain
        SecureUserDefaults.setValue(appleIDCredential.email, forKey: LocalStorageKeys.appleIdEmail)
        MQLAppState.shared.appleIdEmail = appleIDCredential.email
        // Save apple id fullname to keychain
        let appleIdFullname = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
        SecureUserDefaults.setValue(appleIdFullname, forKey: LocalStorageKeys.appleIdFullname)
        MQLAppState.shared.appleIdFullName = appleIdFullname
    }
    
    /**
     Requests sign-in with Apple ID API.
     
     - Parameters:
     - appleIDCredential: Apple ID credential for authentication.
     */
    func requestSignInWithAppleIdAPI(appleIDCredential: ASAuthorizationAppleIDCredential){
        self.appleSignInEventHandler?(.loading)
        guard currentNonce != nil else {
            debugPrint(DebugPrints.invalidState)
            return
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            debugPrint(DebugPrints.unableToFetchIdentityToken)
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            debugPrint("\(DebugPrints.unableToSerializeToken) \(appleIDToken.debugDescription)")
            return
        }
        debugPrint(appleIDToken)
        debugPrint(idTokenString)
        
        if appleIDCredential.email != nil {
            storeAppleEmailAndFullName(appleIDCredential: appleIDCredential)
        }
        
        let parameter: [String : String] = [APIBodyVariables.token : idTokenString,
                                            APIBodyVariables.fullName : MQLAppState.shared.appleIdFullName ?? "",
                                            APIBodyVariables.email : MQLAppState.shared.appleIdEmail ?? ""
        ]
        debugPrint(parameter)
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.appleSignIn(data: parameter)) { (result: Result<LoginResponse, APIError>)  in
            switch result {
            case .success(let response):
                // Delete stored email and password from local storage
                SecureUserDefaults.removeValue(forKey: LocalStorageKeys.emailOrUsername)
                SecureUserDefaults.removeValue(forKey: LocalStorageKeys.password)
                MQLAppState.shared.email = nil
                MQLAppState.shared.password = nil
                // Save token to local storage
                SecureUserDefaults.setValue(response.data.token, forKey: LocalStorageKeys.token)
                MQLAppState.shared.setValues()
                self.appleSignInEventHandler?(.success)
            case .failure(let error):
                self.appleSignInEventHandler?(.error(error: error))
            }
        }
    }
    
    /**
     Observes Apple sign-in events and executes a closure when modal is presented.
     
     - Parameters:
     - isModalPresented: Closure to be executed when modal is presented.
     */
    func observeAppleSignInEvent(isModalPresented: @escaping () -> Void){
        self.appleSignInEventHandler = { appleSignInEvents in
            
            DispatchQueue.main.async {
                switch appleSignInEvents{
                case .loading:
                    self.isLoading = true
                    self.usernameError = nil
                    self.passwordError = nil
                    
                case .success:
                    self.isLoading = false
                    // Close the login model and go to the home screen
                    isModalPresented()
                    
                case .error(error: let error):
                    self.alertMessage = error?.localizedDescription
                    self.isLoading = false
                    self.isAlertPresented = true
                    
                case .connectivityError(error: let error):
                    self.alertMessage = error
                    self.isLoading = false
                    self.isAlertPresented = true
                }
            }
        }
    }
    
    
    
}

//MARK: - Sign In With Apple Id Methods


extension SignInViewModel {
    
    @available(iOS 13, *)
    func signInWithAppleId(viewController: UIViewController) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = viewController as? any ASAuthorizationControllerDelegate
        authorizationController.presentationContextProvider = viewController as? any ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            debugPrint(
                "\(DebugPrints.unableToCreate) \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
}



//MARK: - ASAuthorizationControllerDelegate delegate methods for sign in apple id

@available(iOS 13.0, *)
extension SignInViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            self.requestSignInWithAppleIdAPI(appleIDCredential: appleIDCredential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        debugPrint("\(DebugPrints.signInWithAppleIssue) \(error)")
    }
    
}

