//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 08/01/24.
//

import SwiftUI

struct WebView: View {
    
    @EnvironmentObject var theme: Theme
    @Binding var url: String
    @Binding var title: String
    @StateObject private var viewModel = WebViewViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            VStack {
                //Back Button
                BackButtonWithTitle(action: {
                    presentationMode.wrappedValue.dismiss()
                }, title: title)
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

