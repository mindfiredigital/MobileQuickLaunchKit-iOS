//
//  File.swift
//
//
//  Created by Satyam Tripathi on 08/01/24.
//

import Foundation
import SwiftUI
import WebKit


struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    let url: URL
    
    init(url: URL) {
        self.url = url
        self.webView = WKWebView(frame: .zero)
        self.webView.load(URLRequest(url: url))
        
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
