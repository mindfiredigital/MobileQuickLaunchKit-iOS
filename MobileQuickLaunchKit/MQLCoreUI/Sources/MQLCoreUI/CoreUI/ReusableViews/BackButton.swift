//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 15/12/23.
//

import Foundation
import SwiftUI

public struct BackButton: View {
    var action: () -> Void
    @EnvironmentObject var theme: Theme
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 24))
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
                .foregroundColor(theme.colors.tertiary)
        }
    }
}
