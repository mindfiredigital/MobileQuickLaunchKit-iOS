//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 20/12/23.
//

import Foundation
import CryptoKit

struct SecureUserDefaults {
    private static let encryptionKey = LocalStorageKeys.encryptedKey // It should be of 16, 24, 32 characters

    static func setEncrypted<T: Encodable>(_ value: T, forKey key: String) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)

            if let encryptedData = try? encrypt(data) {
                UserDefaults.standard.set(encryptedData, forKey: key)
            }
        } catch {
            debugPrint("\(DebugPrints.errorEncrypting) \(error)")
        }
    }

    static func getDecrypted<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let encryptedData = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        do {
            if let decryptedData = try? decrypt(encryptedData) {
                let decoder = JSONDecoder()
                return try decoder.decode(type, from: decryptedData)
            }
        } catch {
            debugPrint("\(DebugPrints.errorDecrypting) \(error)")
        }

        return nil
    }

    static func removeValue(forKey key: String) {
          UserDefaults.standard.removeObject(forKey: key)
      }
    
    private static func encrypt(_ data: Data) throws -> Data {
        do {
            let key = SymmetricKey(data: Data(encryptionKey.utf8))
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined ?? Data()
        } catch {
            debugPrint("\(DebugPrints.errorDuringEncryption) \(error)")
            throw error
        }
    }

    private static func decrypt(_ data: Data) throws -> Data {
        let key = SymmetricKey(data: Data(encryptionKey.utf8))
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

