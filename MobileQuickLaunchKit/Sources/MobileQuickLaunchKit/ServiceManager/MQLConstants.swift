//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

public class MQLConstants: NSObject {
    //MARK: - Base URL
    public static var baseURL: String = "http://localhost:3001/api/v1/"
    
    //MARK: - Headers List
    static let SERVER_HEADER_KEYS_AUTHORIZATION = "Authorization";
    static let SERVER_HEADER_KEYS_ACCEPT = "Accept";
    static let SERVER_HEADER_KEYS_CONTENT_MD5 = "Content-MD5";
    static let SERVER_HEADER_KEYS_CONTENT_TYPE = "Content-Type";
    
    //MARK: - Server Constants
    static let DEFAULT_ACCEPT_HEADER = "application/json";
    static let DEFAULT_CONTENT_TYPE = "application/json; charset=UTF-8";
    static let BEARER = "Bearer"
    static let FORM_URLENCODED_HEADER  = "application/x-www-form-urlencoded"
}


// MARK: - Endpoint Strings

struct EndpointStrings{
    static let login = "auth/login"
    static let signUp = "auth/sign_up"
    static let forgetPassword = "auth/password/forgot"
    static let verifyOtp = "auth/password/verification/otp"
    static let resetPassword = "auth/password/reset"
    static let socialSignUp = "auth/social/login_signup"
    static let appleSignUp = "auth/social/apple/login_signup" 
    static let getUserDetails = "user"
    static let updateUserDetails = "user/create-update"
    static let uploadProfileImage = "user/upload/profileImage"
}

// MARK: - API Status

enum Status {
    case loading
    case success
    case error(error: Error)
}

// MARK: - API Error
public enum APIError: Error {
    case invalidData
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case network(_ error: MQLError)
    case connectivity(error: String)
}
