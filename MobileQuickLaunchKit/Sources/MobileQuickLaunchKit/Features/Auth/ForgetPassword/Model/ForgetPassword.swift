//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation


struct ForgetPasswordResponse: Codable {
    let status: String
    let message: String
    let data: String?
    let error: String?
}
