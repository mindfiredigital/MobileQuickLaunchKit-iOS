//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation


struct SignUpResponse: Codable {
    let status: String
    let message: String
    let data: SignUpResponseData
    let error: String?
}

struct SignUpResponseData: Codable {
    let email: String
    let fullname: String
    let phoneNumber: String
    let profileSignedUrl: String
    let token: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
          case email
          case fullname = "full_name"
          case phoneNumber = "phone_number"
          case profileSignedUrl
          case token
          case accessToken = "access_token"
          case refreshToken = "refresh_token"
      }
}
