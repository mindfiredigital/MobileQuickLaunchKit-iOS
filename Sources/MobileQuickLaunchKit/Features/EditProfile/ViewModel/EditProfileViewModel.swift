//
//  File.swift
//
//
//  Created by Satyam Tripathi on 03/01/24.
//

import Foundation
import UIKit
import MQLCore

final class EditProfileViewModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var nameTextField: String = " "
    @Published var nameError: String?
    @Published var phoneNumberTextField: String = ""
    @Published var phoneNumberError: String?
    @Published var emailTextField: String = ""
    @Published var emailError: String?
    @Published var isLoading = false
    @Published var isAlertPresented = false
    @Published var alertMessage: String?
    @Published var alertTitle: String = "Error"
    @Published var isImagePickerPresented = false
    private var userData: UserData?
    
    var getUserEventHandler: ((_ event: APIStatusEvents<UserModel>) -> Void)?
    var updateUserEventHandler: ((_ event: APIStatusEvents<UserModel>) -> Void)?
    var uploadProfileImageHandler: ((_ event: APIStatusEvents<ProfileImage>) -> Void)?
    
    @Published var shouldPresentImagePicker = false
    @Published var shouldPresentActionScheet = false
    @Published var shouldPresentCamera = false
    
    /// This method is used to request the getUser api
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
    
    
    /// This method is used to observe getUser api events
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
    
    /// This method is used when pressing save button
    func onTappedSave() {
        if userData?.fullName != nameTextField || userData?.phoneNumber != phoneNumberTextField {
            updateUserDetail()
        }
    }
    
    
    /// This method is used to request the updateUserDetail api
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
    
    /// This method is used to observe update User api events
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
