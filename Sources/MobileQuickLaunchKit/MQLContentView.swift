//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 13/12/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

@available(iOS 14.0, *)
public struct MQLContentView<MainView: View>: View {
//    public let includedModules: [Module]
    public let mainView: MainView
    @State var isActive: Bool = false
    
    public init(mainView: MainView) {
           self.mainView = mainView
    }
    
    public var body: some View {
        ZStack {
            if self.isActive {
                mainView
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            
            // Configure Firebase
            FirebaseApp.configure()
            if let clientID = FirebaseApp.app()?.options.clientID {
                
                // Create Google Sign In configuration object.
                let config = GIDConfiguration(clientID: clientID)
                GIDSignIn.sharedInstance.configuration = config
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
        
        
    }
}

//@available(iOS 14.0, *)
//#Preview {
//    MQLContentView(includedModules: [.profile])
//        .environmentObject(Theme.theme1)
//}
