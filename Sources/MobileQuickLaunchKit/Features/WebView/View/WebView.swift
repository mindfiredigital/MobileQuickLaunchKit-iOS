//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 08/01/24.
//

import SwiftUI
import MQLCoreUI

/**
 A view for displaying web content within the app.

 The `WebView` struct provides a wrapper around a web view component to display web content fetched from a URL.
*/
struct WebView: View {
    
    /// The theme environment object for styling.
    @EnvironmentObject var theme: Theme
    
    /// Binding to the URL of the web content to be displayed.
    var url: String
    
    /// Binding to the title of the web view.
    var title: String
    
    /// The view model for managing the web view's state and actions.
    @StateObject private var viewModel = WebViewViewModel()
    
    /// Binding to the presentation mode for dismissing the web view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// The body of the web view.
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack {
                //Back Button
                BackButtonWithTitle(title: title.localized(), action: {
                    presentationMode.wrappedValue.dismiss()
                })
                .padding(.leading, 10)
                
                if let url = URL(string: url) {
                    SwiftUIWebView(url: url)
                } else {
                    SwiftUIWebView(url: URL(string: SettingsLinks.defaultURL)!)
                }
            }
            .loader(isLoading: $viewModel.isLoading)
            .navigationBarBackButtonHidden()
        }
        
    }
}

