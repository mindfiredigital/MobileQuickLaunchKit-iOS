//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation

/// A Codable class representing an error response from a server.
/// An instance of MQLError contains information about the error status, error message, additional data (if any), and the error string itself.
public class MQLError: Codable {
    /// The status of the error.
    public let status: String
    
    /// The detailed message describing the error.
    public let message: String
    
    /// Additional data associated with the error, if any.
    public let data: [String : AnyCodable]?
    
    /// The error string.
    public let error: String?
    
    /**
     Initializes an instance of MQLError.
     
     - Parameters:
     - status: The status of the error. Defaults to an empty string.
     - data: Additional data associated with the error. Defaults to nil.
     - message: The detailed message describing the error. Defaults to an empty string.
     - error: The error string. Defaults to an empty string.
     */
    public init(status: String = "", data: [String : AnyCodable]? = nil, message: String = "", error: String = "") {
        self.message = message
        self.status = status
        self.data = data
        self.error = error
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
        case error
    }
}
