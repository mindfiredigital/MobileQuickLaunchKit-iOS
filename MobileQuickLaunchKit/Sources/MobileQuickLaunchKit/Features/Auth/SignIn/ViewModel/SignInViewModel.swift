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

final class SignInViewModel: NSObject, ObservableObject {
    
    @Published var signInEventHandler:((_ event: SignInEvents) -> Void)?
    
    @Published var isSignUpModalPresented = false
    @Published var isForgetPasswordModalPresented = false
    @Published var emailTextField: String = ""
    @Published var usernameError: String?
    
    @Published var passwordTextField: String = ""
    @Published var passwordError: String?
    
    @Published var isAlertPresented = false
    @Published var alertMessage: String?
    @Published var isLoading = false
    
    @Published var isSecure: Bool = true
    
    var googleSignInEventHandler: ((_ event: SocialSignInEvents) -> Void)?
    var appleSignInEventHandler: ((_ event: SocialSignInEvents) -> Void)?
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    /// This method is used to login in the app.
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
    
    ///This func is used to observe sign in api events
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
    
    /// This method is used for face/touch id authentication
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
    
    /// This method is used for sign in with google by using firebase
    func signInWithGoogle(){
        
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
    
    ///This func is used to observe google  sign in api events
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
    
    
    
    
    /// This method is used to store the apple email and fullname in local storage
    func storeAppleEmailAndFullName(appleIDCredential: ASAuthorizationAppleIDCredential) {
        // Save apple id email to keychain
        SecureUserDefaults.setValue(appleIDCredential.email, forKey: LocalStorageKeys.appleIdEmail)
        MQLAppState.shared.appleIdEmail = appleIDCredential.email
        // Save apple id fullname to keychain
        let appleIdFullname = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
        SecureUserDefaults.setValue(appleIdFullname, forKey: LocalStorageKeys.appleIdFullname)
        MQLAppState.shared.appleIdFullName = appleIdFullname
    }
    
    
    /// This method is used to request apple sign in api
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
    
    
    /// This method is used to observe Apple sign in events
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

