//
//  SwiftUIView.swift
//
//
//  Created by Satyam Tripathi on 02/01/24.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var theme: Theme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = EditProfileViewModel()
    
    var body: some View {
        ZStack {
            theme.colors.backGroundPrimary
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack{
                    //Back Button with title
                    
                    BackButtonWithTitle(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, title: "profile")
                    .padding(.trailing, 29)
                    
                    // Profile Image Section
                    ZStack(alignment: .bottomTrailing) {
                        if let image = viewModel.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: ScreenSize.scaleWidth(0.45), height: ScreenSize.scaleHeight(0.25))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                        } else {
                            // Placeholder or loading indicator while image is being loaded
                            ProgressView()
                                .frame(width: ScreenSize.scaleWidth(0.45), height: ScreenSize.scaleHeight(0.25))
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 5)
                        }
                        
                        // Edit Image Button
                        Button(action: {
                            viewModel.shouldPresentActionScheet.toggle()
                        }) {
                            Image(systemName: Icon.pencil)
                                .resizable()
                                .scaledToFit()
                                .frame(width: ScreenSize.scaleWidth(0.1), height: ScreenSize.scaleHeight(0.1)) // Adjust the size as needed
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 5))
                        .foregroundColor(theme.colors.tertiary)
                    }
                    
                    //Name Text Field
                    ThemeTextField(placeholderText: "name", iconName: Icon.user, text: $viewModel.nameTextField, error: $viewModel.nameError)
                        .padding(.top, 30)
                    
                    //Phone Number Text Field
                    ThemeTextField(placeholderText: "phoneNumber", iconName: Icon.phone,  keyBoardType: .phonePad, text: $viewModel.phoneNumberTextField, error: $viewModel.phoneNumberError, isPhoneField: true)
                        .padding(.top, 15)
                    
                    //Email Text Field
                    ThemeTextField(placeholderText: "email", iconName: Icon.email, keyBoardType: .emailAddress, text: $viewModel.emailTextField, error: $viewModel.emailError)
                        .padding(.top, 15)
                        .disabled(true)
                    
                    Spacer()
                    
                    //Save button
                    Button {
                        viewModel.onTappedSave()
                    } label: {
                        Text("save", bundle: .module)
                            .themeButton()
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden()
                .padding(.horizontal, 29)
                .frame(minHeight: ScreenSize.screenHeight - (ScreenSize.topSafeAreaHeight + ScreenSize.bottomSafeAreaHeight))
                .onAppear {
                    viewModel.getUserDetail()
                    viewModel.observeGetUserEvent()
                    viewModel.observeUpdateUserEvent()
                    viewModel.observeUploadImageEvent()
                }
                .sheet(isPresented: $viewModel.shouldPresentImagePicker) {
                    SUImagePickerView(sourceType: viewModel.shouldPresentCamera ? .camera : .photoLibrary, image: $viewModel.profileImage, isPresented: self.$viewModel.shouldPresentImagePicker, vm: viewModel)
                }.actionSheet(isPresented: $viewModel.shouldPresentActionScheet) { () -> ActionSheet in
                            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                viewModel.shouldPresentImagePicker = true
                                viewModel.shouldPresentCamera = true
                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                viewModel.shouldPresentImagePicker = true
                                viewModel.shouldPresentCamera = false
                            }), ActionSheet.Button.cancel()])
                        }
                .showAlert(title: viewModel.alertTitle, isPresented: $viewModel.isAlertPresented, message: viewModel.alertMessage ?? "")
                .loader(isLoading: $viewModel.isLoading)
            }
        }
    }
}

#Preview {
    EditProfileView()
}
