//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import SwiftUI
import MQLCore


public enum Module {
    case settings
    case profile
    // Add more cases as needed
}

enum SignInEvents {
    case loading
    case success(response: LoginResponse)
    case error(error: APIError)
    case emailValidationError(error: String)
    case passwordValidationError(error: String)
}

enum SignUpEvents {
    case loading
    case success(response: SignUpResponse)
    case error(error: APIError)
    case emailValidationError(error: String)
    case passwordValidationError(error: String)
    case fullnameValidationError(error: String)
    case confirmPasswordValidationError(error: String)
}

enum ForgetPasswordEvents<T> {
    case loading
    case success(response: T)
    case error(error: APIError)
    case emailValidationError(error: String)
}

enum OTPVerificationEvents<T> {
    case loading
    case success(response: T)
    case error(error: APIError)
    case otpValidationError(error: String)
}
enum SetPasswordEvents<T> {
    case loading
    case success(response: T)
    case error(error: APIError)
    case passwordValidationError(error: String)
    case confirmPasswordValidationError(error: String)
}

enum APIStatusEvents<T> {
    case loading
    case success(response: T)
    case error(error: APIError)
}

enum UpdateUserEvents<T> {
    case loading
    case success(response: T)
    case error(error: APIError)
    case fullnameValidationError(error: String)
    case phoneValidationError(error: String)
}

enum SocialSignInEvents {
    case loading
    case success
    case error(error: Error?)
    case connectivityError(error: String)
}
