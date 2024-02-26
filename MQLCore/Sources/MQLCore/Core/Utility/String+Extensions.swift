//
//  String+Extensions.swift
//
//
//  Created by Hemant Sudhanshu on 06/02/24.
//

import Foundation
import SwiftUI

extension String {
    
    public func removeOccurance(text: String) -> String {
        return self.replacingOccurrences(of: text, with: "")
    }
    
    public func removeAllWhiteSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    public func removeLeadingAndTrailingWhiteSpaces() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    public func truncate(length: Int, trailing: String = "") -> String {
        return (self.count > length) ? self.prefix(length) + trailing : self
    }
   
}
