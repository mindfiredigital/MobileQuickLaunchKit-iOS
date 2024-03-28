//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 08/01/24.
//

import Foundation

/**
 View model for managing the state and actions of the `WebView`.

 The `WebViewViewModel` class handles the loading state of the web view and provides methods for performing actions related to web content.
*/
final class WebViewViewModel: ObservableObject {
    
    /// Indicates whether the web view is currently loading content.
    @Published var isLoading = false
}
