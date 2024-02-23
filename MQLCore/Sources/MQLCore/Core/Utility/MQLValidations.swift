//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 07/02/24.
//

import UIKit

public class MQLValidations {
    // MARK: - Form Validation Methods
    
    /// This method is used to validate email or mobile in a textfield.
   public static func isValidEmailOrPhoneNumber(text: String) -> Bool {
        
        let mobilePredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.mobileRegex)
        let emailPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.emailRegex)
        
        let isMobile = mobilePredicate.evaluate(with: text)
        let isEmail = emailPredicate.evaluate(with: text)
        
        return isMobile || isEmail
    }
    
    /// This method is used to validate password.
   public static func isStrongPassword(password: String) -> Bool{
       let passwordPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.passwordRegex)
       let isValidPassword = passwordPredicate.evaluate(with: password)
       return isValidPassword
    }
    
    /// This method is used to match password.
   public static func isPasswordMatching(password: String, confirmPassword: String) -> Bool{
       return password == confirmPassword
    }
    
    /// This method is used to validate email.
   public static func isValidEmail(email: String) -> Bool{
        let emailPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.emailRegex)
        let isEmail = emailPredicate.evaluate(with: email)
        return isEmail
    }
    
    /// This method is used to validate mobile number.
   public static func isValidPhoneNumber(phoneNumber: String) -> Bool{
        let mobilePredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.mobileRegex)
        let isMobile = mobilePredicate.evaluate(with: phoneNumber)
        return isMobile
    }
    
    
    /// This method is used to validate numeric input
   public static func isValidNumericInput(input: String) -> Bool{
        let numericPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.numericRegex)
        let isNumeric = numericPredicate.evaluate(with: input)
        return isNumeric
    }
    
    public static func isValidURL( url: String) -> Bool {
        if let url = URL(string: url) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
}


//MARK: - Regex

struct Regex{
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let mobileRegex = "^[0-9]{10}$"
    static let passwordRegex = "(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,15}$"
    static let numericRegex = "^[0-9]{1,}$"
    static let selfMatchFormat = "SELF MATCHES %@"
}
