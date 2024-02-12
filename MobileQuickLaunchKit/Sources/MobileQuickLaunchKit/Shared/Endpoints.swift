//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 09/02/24.
//

import Foundation
import MQLCore

public let normalHeader: [String : String]? = [MQLConstants.SERVER_HEADER_KEYS_CONTENT_TYPE : MQLConstants.DEFAULT_ACCEPT_HEADER]

public func headerWithBearerToken(token: String? = MQLAppState.shared.token) -> [String : String]? {
    return [MQLConstants.SERVER_HEADER_KEYS_CONTENT_TYPE : MQLConstants.DEFAULT_ACCEPT_HEADER,
            MQLConstants.SERVER_HEADER_KEYS_AUTHORIZATION : "\(MQLConstants.BEARER) \(token ?? "")"
    ]
}

extension MQLEndpoint{
    class func login(data: [String: String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.login, method: .post, body: data, header: normalHeader)
    }
    
    class func signUp(data: [String: String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.signUp, method: .post, body: data, header: normalHeader)
    }
    
    class func forgetPassword(data: [String: String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.forgetPassword, method: .post, body: data, header: normalHeader)
    }
    
    class func verifyOtp(otp: Int) -> MQLEndpoint {
        return MQLEndpoint(path: "\(EndpointStrings.verifyOtp)?code=\(otp)", method: .get, header: normalHeader)
    }
    
    class func resetPassword(data: [String: String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.resetPassword, method: .post, body: data, header: normalHeader)
    }
    
    class func socialSignUp(data: [String: String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.socialSignUp, method: .post, body: data, header: normalHeader)
    }
    
    class func appleSignIn(data: [String : String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.appleSignUp, method: .post, body: data, header: normalHeader)
    }
    
    class func getUserDetails() -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.getUserDetails, method: .get, header: headerWithBearerToken())
    }
    
    class func updateUserDetails(data: [String: String]) -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.updateUserDetails, method: .post, body: data, header: headerWithBearerToken())
    }
    
    class func uploadProfileImage() -> MQLEndpoint {
        return MQLEndpoint(path: EndpointStrings.uploadProfileImage, method: .post, header: headerWithBearerToken())
    }
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
