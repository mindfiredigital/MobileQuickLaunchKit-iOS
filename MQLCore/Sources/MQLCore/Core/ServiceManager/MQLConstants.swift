//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

/**
 A class providing constants for network requests and server communication.
 
 MQLConstants encapsulates various constants such as base URL, header keys, default headers, and server constants.
 */
public class MQLConstants: NSObject {
    //MARK: - Base URL
    /// The base URL for the server.
    // MARK: - Base URL
    
    /// The base URL for the server.
    public static var baseURL: String = "http://localhost:3001/api/v1/"
    
    // MARK: - Headers List
    
    /// The key for the Authorization header.
    public static let SERVER_HEADER_KEYS_AUTHORIZATION = "Authorization"
    
    /// The key for the Accept header.
    public static let SERVER_HEADER_KEYS_ACCEPT = "Accept"
    
    /// The key for the Content-MD5 header.
    public static let SERVER_HEADER_KEYS_CONTENT_MD5 = "Content-MD5"
    
    /// The key for the Content-Type header.
    public static let SERVER_HEADER_KEYS_CONTENT_TYPE = "Content-Type"
    
    // MARK: - Server Constants
    
    /// The default value for the Accept header.
    public static let DEFAULT_ACCEPT_HEADER = "application/json"
    
    /// The default value for the Content-Type header.
    public static let DEFAULT_CONTENT_TYPE = "application/json; charset=UTF-8"
    
    /// The bearer token prefix.
    public static let BEARER = "Bearer"
    
    /// The header value for form-urlencoded requests.
    public static let FORM_URLENCODED_HEADER  = "application/x-www-form-urlencoded"
}


// MARK: - API Status

/**
 An enumeration representing the status of an API call.
 */
enum Status {
    case loading
    case success
    case error(error: Error)
}

// MARK: - API Error

/**
 An enumeration representing possible errors that can occur during API calls.
 */
public enum APIError: Error {
    case invalidData
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case network(_ error: MQLError)
    case connectivity(error: String)
}
