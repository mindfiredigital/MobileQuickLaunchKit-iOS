//
//  File.swift
//
//
//  Created by Satyam Tripathi on 15/12/23.
//

import Foundation
import SwiftUI
import MQLCore
import MQLCoreUI


/**
 ViewModel for OTP verification.
 */

class OTPVerificationViewModel: ObservableObject {
    
    /// Environment object for theme styling.
    @EnvironmentObject var theme: Theme
    
    /// The entered OTP field.
    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    
    /// Computed property for the first digit of OTP.
    var otp1: String {
        guard otpField.count >= 1 else {
            return ""
        }
        return String(Array(otpField)[0])
    }
    
    /// Computed property for the second digit of OTP.
    var otp2: String {
        guard otpField.count >= 2 else {
            return ""
        }
        return String(Array(otpField)[1])
    }
    
    /// Computed property for the third digit of OTP.
    var otp3: String {
        guard otpField.count >= 3 else {
            return ""
        }
        return String(Array(otpField)[2])
    }
    
    /// Computed property for the fourth digit of OTP.
    var otp4: String {
        guard otpField.count >= 4 else {
            return ""
        }
        return String(Array(otpField)[3])
    }
    
    /// Computed property for the fifth digit of OTP.
    var otp5: String {
        guard otpField.count >= 5 else {
            return ""
        }
        return String(Array(otpField)[4])
    }
    
    /// Computed property for the sixth digit of OTP.
    var otp6: String {
        guard otpField.count >= 6 else {
            return ""
        }
        return String(Array(otpField)[5])
    }
    
    /// Border color of the OTP text field.
    @Published var borderColor: Color = .black
    
    /// Indicates whether the OTP text field is disabled.
    @Published var isTextFieldDisabled = false
    
    /// Completion handler for successful OTP verification.
    var successCompletionHandler: (() -> Void)?
    
    /// Indicates whether to show the resend OTP text.
    @Published var showResendText = false
    
    /// Indicates the activation status of the view model.
    @Published var isActive: Bool = false
    
    /// Indicates whether an alert is presented.
    @Published var isAlertPresented = false
    
    /// The message to display in the alert.
    @Published var alertMessage: String?
    
    /// Indicates whether a loading indicator is shown.
    @Published var isLoading = false
    
    /// Indicates whether the set new password modal is presented.
    @Published var isSetNewPasswordModalPresented = false
    
    /// Indicates the focus status of the OTP field.
    @Published var isFocused = false
    
    /// Error message related to OTP validation.
    @Published var otpError: String?
    
    /// Width of the OTP text box.
    let textBoxWidth = UIScreen.main.bounds.width / 8
    
    /// Height of the OTP text box.
    let textBoxHeight = UIScreen.main.bounds.width / 8
    
    /// Spacing between OTP boxes.
    let spaceBetweenBoxes: CGFloat = 10
    
    /// Padding of the OTP box.
    let paddingOfBox: CGFloat = 1
    
    /// Original width of the OTP text field.
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6) + (spaceBetweenBoxes*3) + ((paddingOfBox*2)*3)
    }
    
    /// Closure to handle OTP verification events.
    @Published var verifyOTPEventHandler: ((_ event: OTPVerificationEvents<OTPVerificationResponse>) -> Void)?
    
    /**
     Sends a request to verify the OTP.
     
     This method sends a request to the server to verify the entered OTP.
     */
    func verifyOTP() {
        self.verifyOTPEventHandler?(.loading)
        
        if otpField.count != 6 {
            self.verifyOTPEventHandler?(.otpValidationError(error: "invalidOTP"))
            return
        }
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.verifyOtp(otp: Int(otpField) ?? 0)) { (result: Result<OTPVerificationResponse, APIError>)  in
            switch result {
                
            case .success(let response):
                self.verifyOTPEventHandler?(.success(response: response))
            case .failure(let error):
                self.verifyOTPEventHandler?(.error(error: error))
            }
        }
    }
    
    /**
     Observes the state of OTP verification.
     
     This method observes the state of OTP verification events and updates the view model accordingly.
     */
    func observeVerifyOtpState() {
        self.verifyOTPEventHandler = { verifyOTPEvent in
            
            DispatchQueue.main.async {
                
                switch verifyOTPEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.otpError = nil
                    
                case .success(response: _):
                    self.isSetNewPasswordModalPresented.toggle()
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
                    
                case .otpValidationError(error: let error):
                    self.otpError = error
                    self.isLoading = false
                }
                
            }
        }
    }
    
}


