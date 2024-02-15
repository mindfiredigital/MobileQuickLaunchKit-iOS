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
    public static let SERVER_HEADER_KEYS_AUTHORIZATION = "Authorization";
    public static let SERVER_HEADER_KEYS_ACCEPT = "Accept";
    public static let SERVER_HEADER_KEYS_CONTENT_MD5 = "Content-MD5";
    public static let SERVER_HEADER_KEYS_CONTENT_TYPE = "Content-Type";
    
    //MARK: - Server Constants
    public static let DEFAULT_ACCEPT_HEADER = "application/json";
    public static let DEFAULT_CONTENT_TYPE = "application/json; charset=UTF-8";
    public static let BEARER = "Bearer"
    public static let FORM_URLENCODED_HEADER  = "application/x-www-form-urlencoded"
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
