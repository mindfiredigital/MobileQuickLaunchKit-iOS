//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 20/12/23.
//

import Foundation
import MQLCore

public class MQLAppState {
    public static let shared = MQLAppState()
    private init() {}
    
    var email: String?
    var password: String?
    public var token: String?
    var appleIdEmail: String?
    var appleIdFullName: String?
    
    ///This is used to reset the app state
    func resetState() {
        email = nil
        password = nil
        token = nil
        appleIdEmail = nil
        appleIdFullName = nil
    }
    
    /// This method is used to read the value from keychain and set it to the appstate class variables
   public func setValues(){
        
        //Retrive email from local storage to set it to appstate variable
        if let retrievedEmail: String = SecureUserDefaults.getValue(String.self, forKey: LocalStorageKeys.emailOrUsername) {
            debugPrint("\(DebugPrints.retrivedEmail) \(retrievedEmail)")
            self.email = retrievedEmail
        } else {
            debugPrint(DebugPrints.emailNotFound)
        }
        
        //Retrive password from local storage to set it to appstate variable
        if let retrievedPassword: String = SecureUserDefaults.getValue(String.self, forKey: LocalStorageKeys.password) {
            debugPrint("\(DebugPrints.retrivedPassword) \(retrievedPassword)")
            self.password = retrievedPassword
        } else {
            debugPrint(DebugPrints.passwordNotFound)
        }
        
        //Retrive token from local storage to set it to appstate variable
        if let retrievedToken: String = SecureUserDefaults.getValue(String.self, forKey: LocalStorageKeys.token) {
            debugPrint("\(DebugPrints.retrivedToken) \(retrievedToken)")
            self.token = retrievedToken
        } else {
            debugPrint(DebugPrints.tokenNotFound)
        }
        
        //Retrive appleId email from local storage to set it to appstate variable
        if let retrievedAppleIdEmail: String = SecureUserDefaults.getValue(String.self, forKey: LocalStorageKeys.appleIdEmail) {
            debugPrint("\(DebugPrints.retrivedAppleIdEmail) \(retrievedAppleIdEmail)")
            self.appleIdEmail = retrievedAppleIdEmail
        } else {
            debugPrint(DebugPrints.appleIdEmailNotFound)
        }
        
        //Retrive appleId fullname from local storage to set it to appstate variable
        if let retrievedAppleIdFullname: String = SecureUserDefaults.getValue(String.self, forKey: LocalStorageKeys.appleIdFullname) {
            debugPrint("\(DebugPrints.retrivedAppleIdfullname) \(retrievedAppleIdFullname)")
            self.appleIdFullName = retrievedAppleIdFullname
        } else {
            debugPrint(DebugPrints.appleIdFullnameNotFound)
        }
        
    }
    
    /// This method is used to find whether the user is logged in or not
    public func isUserLoggedIn () -> Bool {
        
        if token != nil{
            return true
        }
        return false
    }
}
