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


class OTPVerificationViewModel: ObservableObject {
    
    @EnvironmentObject var theme: Theme
    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    var otp1: String {
        guard otpField.count >= 1 else {
            return ""
        }
        return String(Array(otpField)[0])
    }
    var otp2: String {
        guard otpField.count >= 2 else {
            return ""
        }
        return String(Array(otpField)[1])
    }
    var otp3: String {
        guard otpField.count >= 3 else {
            return ""
        }
        return String(Array(otpField)[2])
    }
    var otp4: String {
        guard otpField.count >= 4 else {
            return ""
        }
        return String(Array(otpField)[3])
    }
    
    var otp5: String {
        guard otpField.count >= 5 else {
            return ""
        }
        return String(Array(otpField)[4])
    }
    
    var otp6: String {
        guard otpField.count >= 6 else {
            return ""
        }
        return String(Array(otpField)[5])
    }
    
    @Published var borderColor: Color = .black
    @Published var isTextFieldDisabled = false
    var successCompletionHandler: (()->())?
    @Published var showResendText = false
    
    
    @Published var isActive: Bool = false
    @Published var isAlertPresented = false
    @Published var alertMessage: String?
    @Published var isLoading = false
    @Published var isSetNewPasswordModalPresented = false
    @Published var isFocused = false
    @Published var otpError: String?
    
    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6) + (spaceBetweenBoxes*3) + ((paddingOfBox*2)*3)
    }
    
    @Published var verifyOTPEventHandler:((_ event: OTPVerificationEvents<OTPVerificationResponse>) -> Void)?
    
    /// This func is used to request verify otp api
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
    
    ///This func is used to observe Verify OTP api events
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


