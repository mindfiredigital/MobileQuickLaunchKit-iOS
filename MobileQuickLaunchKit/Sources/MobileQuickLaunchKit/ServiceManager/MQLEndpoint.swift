//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 22/01/24.
//

import Foundation

// MARK: - Headers

public let normalHeader: [String : String]? = [MQLConstants.SERVER_HEADER_KEYS_CONTENT_TYPE : MQLConstants.DEFAULT_ACCEPT_HEADER]

public func headerWithBearerToken(token: String? = MQLAppState.shared.token) -> [String : String]? {
    return [MQLConstants.SERVER_HEADER_KEYS_CONTENT_TYPE : MQLConstants.DEFAULT_ACCEPT_HEADER,
            MQLConstants.SERVER_HEADER_KEYS_AUTHORIZATION : "\(MQLConstants.BEARER) \(token ?? "")"
    ]
}

public class MQLEndpoint: EndpointType {
    public var path: String
    public var url: URL?
    public var method: HTTPMethod
    public var body: Encodable?
    public var header: [String : String]?
    
    public init(path: String, method: HTTPMethod, body: Encodable? = nil, header: [String : String]? = nil) {
        self.path = path
        self.url = URL(string: MQLConstants.baseURL + path)
        self.method = method
        self.body = body
        self.header = header
    }
    
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


// MARK: - EndpointType Protocol
protocol EndpointType {
    var path: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var header: [String : String]? { get }
}


// MARK: - HTTPMethod
public enum HTTPMethod :String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
