//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 22/01/24.
//

import Foundation


/**
 A class representing an endpoint for making network requests.
 
 An instance of MQLEndpoint encapsulates information about the endpoint's path, URL, HTTP method, request body (if any), and request headers.
 */
public class MQLEndpoint: EndpointType {
    
    /// The path component of the endpoint's URL.
    public var path: String
    
    /// The complete URL formed by appending the path to the base URL.
    public var url: URL?
    
    /// The HTTP method to be used for the request.
    public var method: HTTPMethod
    
    /// The body of the request, if any, to be encoded as JSON.
    public var body: Encodable?
    
    /// The headers to be included in the request, if any.
    public var header: [String : String]?
    
    /**
     Initializes an instance of MQLEndpoint.
     
     - Parameters:
     - path: The path component of the endpoint's URL.
     - method: The HTTP method to be used for the request.
     - body: The body of the request, if any. Defaults to nil.
     - header: The headers to be included in the request, if any. Defaults to nil.
     */
    public init(path: String, method: HTTPMethod, body: Encodable? = nil, header: [String : String]? = nil) {
        self.path = path
        self.url = URL(string: MQLConstants.baseURL + path)
        self.method = method
        self.body = body
        self.header = header
    }
}


// MARK: - EndpointType Protocol
/**
 A protocol defining properties required for an endpoint.
 */
protocol EndpointType {
    var path: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var header: [String : String]? { get }
}


// MARK: - HTTPMethod
/**
 An enumeration representing HTTP methods for network requests.
 */
public enum HTTPMethod :String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
