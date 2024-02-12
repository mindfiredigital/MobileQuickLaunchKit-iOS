//
//  File.swift
//  
//
//  Created by Hemant Sudhanshu on 09/02/24.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, bundle: .module, comment: "")
    }
}
