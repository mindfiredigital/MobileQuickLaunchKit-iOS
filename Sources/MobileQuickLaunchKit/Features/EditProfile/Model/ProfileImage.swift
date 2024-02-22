//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 18/01/24.
//

import Foundation
struct ImageData: Codable {
    let profileSignedUrl: URL
}

struct ProfileImage: Codable {
    let status: String
    let message: String
    let data: ImageData
    let error: String?
}
