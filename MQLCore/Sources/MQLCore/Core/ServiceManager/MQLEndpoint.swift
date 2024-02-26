//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 22/01/24.
//

import Foundation


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
