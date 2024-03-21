//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 20/12/23.
//

import Foundation
import CryptoKit
//MARK: - LocalStorageKeys

/**
 A utility struct for securely storing and retrieving encrypted values in UserDefaults.
 */
public struct SecureUserDefaults {
    /// The encryption key used for encrypting and decrypting data. It should be of 16, 24, or 32 characters.
    private static let encryptionKey = "MobileQuickLaunchKitKeys"
    
    /**
     Saves encrypted values to the UserDefaults.
     
     - Parameters:
     - value: The value to be encrypted and saved.
     - key: The key associated with the value.
     */
    public static func setValue<T: Encodable>(_ value: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            
            if let encryptedData = try? encrypt(data) {
                UserDefaults.standard.set(encryptedData, forKey: key)
            }
        } catch {
            debugPrint("Error encrypting and saving data: \(error)")
        }
    }
    
    /**
     Retrieves encrypted values from the UserDefaults.
     
     - Parameters:
     - type: The type of value to be retrieved.
     - key: The key associated with the value.
     - Returns: The decrypted value of the specified type, if available; otherwise, nil.
     */
    public static func getValue<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let encryptedData = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            if let decryptedData = try? decrypt(encryptedData) {
                let decoder = JSONDecoder()
                return try decoder.decode(type, from: decryptedData)
            }
        } catch {
            debugPrint("Error decrypting and retrieving data: \(error)")
        }
        
        return nil
    }
    
    /**
     Removes encrypted values from the UserDefaults.
     
     - Parameter key: The key associated with the value to be removed.
     */
    public static func removeValue(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    /**
     Encrypts the provided data using AES-GCM encryption.
     
     - Parameter data: The data to be encrypted.
     - Throws: An error if encryption fails.
     - Returns: The encrypted data.
     */
    private static func encrypt(_ data: Data) throws -> Data {
        do {
            let key = SymmetricKey(data: Data(encryptionKey.utf8))
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined ?? Data()
        } catch {
            debugPrint("Error during encryption: \(error)")
            throw error
        }
    }
    
    /**
     Decrypts the provided data using AES-GCM decryption.
     
     - Parameter data: The data to be decrypted.
     - Throws: An error if decryption fails.
     - Returns: The decrypted data.
     */
    private static func decrypt(_ data: Data) throws -> Data {
        let key = SymmetricKey(data: Data(encryptionKey.utf8))
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

