//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 04/01/24.
//

import Foundation


struct UserData: Codable {
    let email: String
    let fullName: String
    let phoneNumber: String
    let profileSignedUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case email
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case profileSignedUrl
    }
    
}

struct UserModel: Codable {
    let status: String
    let message: String
    let data: UserData
    let error: String?
}

