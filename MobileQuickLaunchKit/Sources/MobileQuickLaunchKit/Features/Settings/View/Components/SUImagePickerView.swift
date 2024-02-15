//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 03/01/24.
//

import SwiftUI

struct SUImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var vm: EditProfileViewModel?
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, vm: vm)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var vm: EditProfileViewModel?
    
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>, vm: EditProfileViewModel?) {
        self._image = image
        self._isPresented = isPresented
        self.vm = vm
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.isPresented = false
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if vm != nil {
                vm?.uploadImage(image: image)
            } else {
                self.image = image
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}
