//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 08/01/24.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isEditProfileActive: Bool = false
    @Published var isWebViewActive: Bool = false
    @Published var webViewURL: String = ""
    @Published var webViewTitle: String = ""
    @Published var isChangePasswordActive: Bool = false
}
