//
//  File.swift
//
//
//  Created by Satyam Tripathi on 13/12/23.
//

import Foundation



//MARK: - Regex

struct Regex{
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let mobileRegex = "^[0-9]{10}$"
    static let selfMatchFormat = "SELF MATCHES %@"
}

//MARK: - Icon

struct Icon {
    static let companyLogo = "CompanyLogo"
    static let user = "User"
    static let lock = "Lock"
    static let google = "Google"
    static let facebook = "Facebook"
    static let twitter = "Twitter"
    static let linkedIn = "LinkedIn"
    static let eyeClose = "eye.slash"
    static let eye = "eye"
    static let email = "Email"
    static let backIcon = "chevron.left"
    static let faceId = "faceid"
    static let apple = "Apple"
    static let account = "Account"
    static let other = "Other"
    static let pencil = "square.and.pencil.circle.fill"
    static let phone = "phone"
}

//MARK: - APIBodyVariables

struct APIBodyVariables {
    static let email = "email"
    static let password = "password"
    static let fullName = "full_name"
    static let confirmPassword = "confirm_password"
    static let token = "token"
    static let phoneNumber = "phone_no"
    static let isUpdate = "is_update"
}

//MARK: - LocalStorageKeys

struct LocalStorageKeys {
    static let emailOrUsername = "emailOrUsername"
    static let password = "password"
    static let token = "token"
    static let encryptedKey = "MobileQuickLaunchKitKeys"
    static let appleIdEmail = "appleIdEmail"
    static let appleIdFullname = "appleIdFullname"
}

//MARK: - DebugPrints

struct DebugPrints {
    static let emailNotFound = "Email not found or decryption failed."
    static let passwordNotFound = "Password not found or decryption failed."
    static let tokenNotFound = "Token not found or decryption failed."
    static let appleIdEmailNotFound = "Apple Id email not found or decryption failed."
    static let appleIdFullnameNotFound = "Apple Id fullname not found or decryption failed."
    static let retrivedEmail = "Retrieved email"
    static let retrivedPassword = "Retrieved password"
    static let retrivedToken = "Retrieved token"
    static let retrivedAppleIdEmail = "Retrieved token"
    static let retrivedAppleIdfullname = "Retrieved fullname"
    static let errorEncrypting =  "Error encrypting and saving data:"
    static let errorDecrypting = "Error decrypting and retrieving data:"
    static let errorDuringEncryption = "Error during encryption:"
    static let faceIDPolicyError = "Can't evaluate policy"
    static let unableToCreate = "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus"
    static let signInWithAppleIssue = "Sign in with Apple errored:"
    static let unableToFetchIdentityToken = "Unable to fetch identity token"
    static let unableToSerializeToken  = "Unable to serialize token string from data:"
    static let invalidState = "Invalid state: A login callback was received, but no login request was sent."
}

struct SettingsLinks {
    static let privacy = "https://www.mindfiresolutions.com/privacy-policy/"
    static let aboutUs = "https://www.mindfiresolutions.com/news/"
    static let help = "https://www.mindfiresolutions.com/contact-us/"
    static let defaultURL = "https://www.google.com"
}
