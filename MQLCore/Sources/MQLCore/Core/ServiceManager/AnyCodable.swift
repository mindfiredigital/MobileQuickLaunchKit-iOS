//
//  File.swift
//
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation


/// AnyCodable is a struct that facilitates encoding and decoding of values of any type conforming to `Codable`.
public struct AnyCodable: Codable {
    /// The value of any type to be encoded or decoded.
    let value: Any
    
    /// Private struct `CodingKeys` used for custom key coding.
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    /// Initializes an `AnyCodable` struct from the given decoder.
    /// - Parameter decoder: The decoder to decode data from.
    /// - Throws: An error if the decoding process fails.
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            var result = [String: Any]()
            try container.allKeys.forEach { (key)
                throws in
                result[key.stringValue] = try container.decode(AnyCodable.self, forKey: key).value
            }
            value = result
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [Any]()
            while !container.isAtEnd {
                result.append(try container.decode(AnyCodable.self).value)
            }
            value = result
        } else if let container = try? decoder.singleValueContainer() {
            if container.decodeNil() {
                // If the value is nil, set the `value` to `NSNull()`
                value = NSNull()
            }
            else if let intValue = try? container.decode(Int.self) {
                value = intValue
            } else if let doubleValue = try? container.decode(Double.self) {
                value = doubleValue
            } else if let boolValue = try? container.decode(Bool.self) {
                value = boolValue
            } else if let stringValue = try? container.decode(String.self) {
                value = stringValue
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "the container contains nothing serialisable")
            }
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not serialise"))
        }
    }
    
    /// Initializes an `AnyCodable` struct with the given value.
    /// - Parameter value: The value to be encoded or decoded.
    public init(value: Any) {
        self.value = value
    }
    
    /// Encodes the `AnyCodable` struct using the provided encoder.
    /// - Parameter encoder: The encoder to encode data with.
    /// - Throws: An error if the encoding process fails.
    public func encode(to encoder: Encoder) throws {
        if let array = value as? [Any] {
            var container = encoder.unkeyedContainer()
            for value in array {
                let decodable = AnyCodable(value: value)
                try container.encode(decodable)
            }
        } else if let dictionary = value as? [String: Any] {
            var container = encoder.container(keyedBy: CodingKeys.self)
            for (key, value) in dictionary {
                let codingKey = CodingKeys(stringValue: key)!
                let decodable = AnyCodable(value: value)
                try container.encode(decodable, forKey: codingKey)
            }
        } else {
            var container = encoder.singleValueContainer()
            if let intValue = value as? Int {
                try container.encode(intValue)
            } else if let doubleValue = value as? Double {
                try container.encode(doubleValue)
            } else if let boolValue = value as? Bool {
                try container.encode(boolValue)
            } else if let stringValue = value as? String {
                try container.encode(stringValue)
            } else {
                throw EncodingError.invalidValue(value, EncodingError.Context.init(codingPath: [], debugDescription: "The value is not encodable"))
            }
        }
    }
}
