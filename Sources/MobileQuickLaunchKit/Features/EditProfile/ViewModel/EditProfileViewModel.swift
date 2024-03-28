//
//  File.swift
//
//
//  Created by Satyam Tripathi on 03/01/24.
//

import Foundation
import UIKit
import MQLCore

/**
 View model for managing user profile editing.

 This class handles user interactions and API requests related to editing user profile information, such as name, phone number, and profile image.

 Usage:
 - Initialize an instance of `EditProfileViewModel` to manage profile editing logic and state.
 - Call the `getUserDetail` method to fetch user details from the server.
 - Call the `onTappedSave` method when the user taps the save button to update profile details.
 - Call the `uploadImage` method to upload a new profile image.
 - Use the published properties to observe changes in profile data and UI state.

 Example:
let profileViewModel = EditProfileViewModel()

- Requires: `UserData` model to store user details, `Theme` environment object for styling, and network services for API requests.
*/
final class EditProfileViewModel: ObservableObject {
   
    /// The profile image of the user.
    @Published var profileImage: UIImage?
    
    /// The name entered by the user in the text field.
    @Published var nameTextField: String = " "
    
    /// Error message for name field validation.
    @Published var nameError: String?
    
    /// The phone number entered by the user in the text field.
    @Published var phoneNumberTextField: String = ""
    
    /// Error message for phone number field validation.
    @Published var phoneNumberError: String?
    
    /// The email address entered by the user in the text field.
    @Published var emailTextField: String = ""
    
    /// Error message for email field validation.
    @Published var emailError: String?
    
    /// Loading state indicator.
    @Published var isLoading = false
    
    /// Indicates whether an alert should be presented.
    @Published var isAlertPresented = false
    
    /// The message to be displayed in the alert.
    @Published var alertMessage: String?
    
    /// The title of the alert.
    @Published var alertTitle: String = "Error"
    
    /// Indicates whether the image picker view is presented.
    @Published var isImagePickerPresented = false
    
    /// Event handler for getUser API events.
    var getUserEventHandler: ((_ event: APIStatusEvents<UserModel>) -> Void)?
    
    /// Event handler for updateUser API events.
    var updateUserEventHandler: ((_ event: APIStatusEvents<UserModel>) -> Void)?
    
    /// Event handler for uploadProfileImage API events.
    var uploadProfileImageHandler: ((_ event: APIStatusEvents<ProfileImage>) -> Void)?
    
    /// Indicates whether the image picker should be presented.
    @Published var shouldPresentImagePicker = false
    
    /// Indicates whether the action sheet for choosing camera or photo library should be presented.
    @Published var shouldPresentActionScheet = false
    
    /// Indicates whether the camera should be presented when selecting an image.
    @Published var shouldPresentCamera = false
    
    /// The user data fetched from the server.
    private var userData: UserData?
    
    /// Initializes a new instance of `EditProfileViewModel`.
    init() {}
    
    /// This method is used to request user details from the server.
    func getUserDetail() {
        self.getUserEventHandler?(.loading)
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.getUserDetails()) { (result: Result<UserModel, APIError>)  in
            
            switch result {
                
            case .success(let response):
                self.getUserEventHandler?(.success(response: response))
            case .failure(let error):
                self.getUserEventHandler?(.error(error: error))
            }
        }
    }
    
    /// This method is used to handle the getUser API events.
    func observeGetUserEvent() {
        self.getUserEventHandler = {  getUserEvent in
            
            DispatchQueue.main.async {
                switch getUserEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.nameError = nil
                    self.phoneNumberError = nil
                    
                case .success(response: let response):
                    
                    self.isLoading = false
                    self.loadImageFromURL(url: response.data.profileSignedUrl)
                    self.nameTextField = response.data.fullName
                    self.phoneNumberTextField = response.data.phoneNumber
                    self.emailTextField = response.data.email
                    self.userData = response.data
                    
                case .error(error: let error):
                    switch error {
                    case .connectivity(error: let error):
                        self.alertMessage = error
                        
                    case .network(error: let error):
                        self.alertMessage = error.message
                        
                    default:
                        self.alertMessage = "somethingWentWrong"
                    }
                    self.isLoading = false
                    self.isAlertPresented = true
                }
            }
        }
    }
    
    /// This method is called when the user taps the save button to update profile details.
    func onTappedSave() {
        if userData?.fullName != nameTextField || userData?.phoneNumber != phoneNumberTextField {
            updateUserDetail()
        }
    }
    
    
    /// This method is used to request the updateUserDetail API.
    func updateUserDetail() {
        self.updateUserEventHandler?(.loading)
        
        /// is_update = 0 for creation, is_update = 1 for updation
        let parameters = [
            APIBodyVariables.fullName : nameTextField,
            APIBodyVariables.phoneNumber : phoneNumberTextField,
            APIBodyVariables.isUpdate : "1"
        ]
        
        MQLBaseService.shared.request(endpoint: MQLEndpoint.updateUserDetails(data: parameters)) { (result: Result<UserModel, APIError>)  in
            
            switch result {
                
            case .success(let response):
                self.updateUserEventHandler?(.success(response: response))
            case .failure(let error):
                self.updateUserEventHandler?(.error(error: error))
            }
        }
    }
    
    /// This method is used to observe updateUser API events.
    func observeUpdateUserEvent() {
        self.updateUserEventHandler = {  updateUserEvent in
            
            DispatchQueue.main.async {
                switch updateUserEvent {
                    
                case .loading:
                    self.isLoading = true
                    self.nameError = nil
                    self.phoneNumberError = nil
                    
                case .success(response: let response):
                    
                    self.isLoading = false
                    self.nameTextField = response.data.fullName
                    self.loadImageFromURL(url: response.data.profileSignedUrl)
                    self.phoneNumberTextField = response.data.phoneNumber
                    self.emailTextField = response.data.email
                    self.alertMessage = "profileUpdatedSuccessfully"
                    self.alertTitle = "appName"
                    self.isAlertPresented = true
                    
                case .error(error: let error):
                    switch error {
                    case .connectivity(error: let error):
                        self.alertMessage = error
                        
                    case .network(error: let error):
                        self.alertMessage = error.message
                        
                    default:
                        self.alertMessage = "somethingWentWrong"
                    }
                    self.isLoading = false
                    self.isAlertPresented = true
                    
                }
            }
        }
    }
    
    /// This function is used to load the image from the url
    func loadImageFromURL(url: URL?) {
        guard let url = url else {
            return
        }
        
        Utilities.loadImage(from: url) { image in
            DispatchQueue.main.async {
                self.profileImage = image
            }
        }
    }
    
    /// To upload profile image
    func uploadImage(image: UIImage) {
        self.uploadProfileImageHandler?(.loading)
        
        /// generate boundary string using a unique per-app string. For internal use only
        let boundary = UUID().uuidString
        
        //Generate request data
        let requestData = generateImageRequestData(boundary: boundary, image: image)
        
        MQLBaseService.shared.uploadImage(endpoint: MQLEndpoint.uploadProfileImage(), requestData: requestData, boundary: boundary){ (result: Result<ProfileImage, APIError>)  in
            
            switch result {
            case .success(let response):
                self.uploadProfileImageHandler?(.success(response: response))
            case .failure(let error):
                self.uploadProfileImageHandler?(.error(error: error))
            }
        }
    }
    
    private func generateImageRequestData(boundary: String, image: UIImage) -> Data {
        let filename = "profile.png"
        var data = Data()
        
        // Add the prompt field and its value to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=api_token\r\n\r\n".data(using: .utf8)!)
        data.append(String(describing: UserDefaults.standard.string(forKey: "api_token")).data(using: .utf8)!)
        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=profile_img; filename=\"\(filename)\"\r\n\r\n".data(using: .utf8)!)
        data.append(String(describing: UserDefaults.standard.string(forKey: "api_token")).data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
    /// This method is used to observe pload profile image api events
    func observeUploadImageEvent() {
        self.uploadProfileImageHandler = {  uploadProfileImageEvent in
            
            DispatchQueue.main.async {
                switch uploadProfileImageEvent {
                    
                case .loading:
                    self.isLoading = true
                    
                case .success(response: let response):
                    
                    self.isLoading = false
                    self.loadImageFromURL(url: response.data.profileSignedUrl)
                    self.alertMessage = "profileImageUpdatedSuccessfully"
                    self.alertTitle = "appName"
                    self.isAlertPresented = true
                    
                case .error(error: let error):
                    switch error {
                    case .connectivity(error: let error):
                        self.alertMessage = error
                        
                    case .network(error: let error):
                        self.alertMessage = error.message
                        
                    default:
                        self.alertMessage = "somethingWentWrong"
                    }
                    self.isLoading = false
                    self.isAlertPresented = true
                    
                }
            }
        }
    }
}
