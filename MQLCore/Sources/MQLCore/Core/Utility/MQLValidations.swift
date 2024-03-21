//
//  File.swift
//
//
//  Created by Hemant Sudhanshu on 07/02/24.
//

import UIKit

/**
 A utility class providing methods for various types of input validations.
 
 MQLValidations encapsulates methods for validating email addresses, phone numbers, passwords, and other types of input.
 */
public class MQLValidations {
    // MARK: - Form Validation Methods
    
    /**
     Validates whether the given text is a valid email or phone number.
     
     - Parameter text: The text to be validated.
     - Returns: A boolean value indicating whether the text is valid.
     */
    public static func isValidEmailOrPhoneNumber(text: String) -> Bool {
        
        let mobilePredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.mobileRegex)
        let emailPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.emailRegex)
        
        let isMobile = mobilePredicate.evaluate(with: text)
        let isEmail = emailPredicate.evaluate(with: text)
        
        return isMobile || isEmail
    }
    
    /**
     Validates whether the given password is strong.
     
     - Parameter password: The password to be validated.
     - Returns: A boolean value indicating whether the password is strong.
     */
    public static func isStrongPassword(password: String) -> Bool{
        let passwordPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.passwordRegex)
        let isValidPassword = passwordPredicate.evaluate(with: password)
        return isValidPassword
    }
    
    /**
     Validates whether both passwords match.
     
     - Parameters:
     - password: The first password.
     - confirmPassword: The confirmation password.
     - Returns: A boolean value indicating whether the passwords match.
     */
    public static func isPasswordMatching(password: String, confirmPassword: String) -> Bool{
        return password == confirmPassword
    }
    
    /**
     Validates whether the given text is a valid email.
     
     - Parameter email: The email address to be validated.
     - Returns: A boolean value indicating whether the email is valid.
     */
    public static func isValidEmail(email: String) -> Bool{
        let emailPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.emailRegex)
        let isEmail = emailPredicate.evaluate(with: email)
        return isEmail
    }
    
    /**
     Validates whether the given text is a phone number.
     
     - Parameter phoneNumber: The phone number to be validated.
     - Returns: A boolean value indicating whether the phone number is valid.
     */
    public static func isValidPhoneNumber(phoneNumber: String) -> Bool{
        let mobilePredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.mobileRegex)
        let isMobile = mobilePredicate.evaluate(with: phoneNumber)
        return isMobile
    }
    
    
    /**
     Validates whether the given text is a valid numeric input.
     
     - Parameter input: The text to be validated.
     - Returns: A boolean value indicating whether the input is numeric.
     */
    public static func isValidNumericInput(input: String) -> Bool{
        let numericPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.numericRegex)
        let isNumeric = numericPredicate.evaluate(with: input)
        return isNumeric
    }
    
    /**
     Validates whether the given text is a valid URL.
     
     - Parameter url: The URL string to be validated.
     - Returns: A boolean value indicating whether the URL is valid.
     */
    public static func isValidURL( url: String) -> Bool {
        if let url = URL(string: url) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
}

/// A structure containing regular expressions for various validations.
struct Regex{
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let mobileRegex = "^[0-9]{10}$"
    static let passwordRegex = "(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,15}$"
    static let numericRegex = "^[0-9]{1,}$"
    static let selfMatchFormat = "SELF MATCHES %@"
}
