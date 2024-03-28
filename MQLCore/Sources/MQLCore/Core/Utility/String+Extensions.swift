//
//  String+Extensions.swift
//
//
//  Created by Hemant Sudhanshu on 06/02/24.
//

import Foundation
import SwiftUI

/**
 A set of utility methods for manipulating strings.
 */
extension String {
    
    /**
     Removes occurrences of a specified text from the string.
     
     - Parameter text: The text to be removed from the string.
     - Returns: The modified string after removing occurrences of the specified text.
     */
    public func removeOccurance(text: String) -> String {
        return self.replacingOccurrences(of: text, with: "")
    }
    
    /**
     Removes all white spaces from the string.
     
     - Returns: The modified string after removing all white spaces.
     */
    public func removeAllWhiteSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    /**
     Removes leading and trailing white spaces from the string.
     
     - Returns: The modified string after removing leading and trailing white spaces.
     */
    public func removeLeadingAndTrailingWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    /**
     Truncates the string to a specified length.
     
     - Parameters:
     - length: The maximum length of the truncated string.
     - trailing: The string to append after truncating (default is an empty string).
     - Returns: The truncated string with a specified maximum length, appending the trailing string if the original string exceeds the specified length.
     */
    public func truncate(length: Int, trailing: String = "") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
    
}
