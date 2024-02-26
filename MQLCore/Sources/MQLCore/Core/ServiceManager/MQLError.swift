//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation

public class MQLError: Codable {
    public let status: String
    public let message: String
    public let data: [String : AnyCodable]?
    public let error: String?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
        case error
    }
    
    init(status: String = "", data: [String : AnyCodable]? = nil, message: String = "", error: String = "") {
        self.message = message
        self.status = status
        self.data = data
        self.error = error
    }
}
