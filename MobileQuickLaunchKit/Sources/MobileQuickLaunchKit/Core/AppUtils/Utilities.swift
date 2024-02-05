//
//  File.swift
//
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import UIKit

public class Utilities: NSObject {
    
    // MARK: - Form Validation Methods
    
    /// This method is used to validate email or mobile in a textfield.
   public static func validateFieldForEmailOrMobileNumber(_ text: String) -> Bool {
        
        let mobilePredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.mobileRegex)
        let emailPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.emailRegex)
        
        let isMobile = mobilePredicate.evaluate(with: text)
        let isEmail = emailPredicate.evaluate(with: text)
        
        return isMobile || isEmail
    }
    
    /// This method is used to validate password.
   public static func validatePassword(_ text: String) -> Bool{
        text.count >= 8 ? true : false
    }
    
    /// This method is used to validate email.
   public static func validateEmail(_ text:String) -> Bool{
        let emailPredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.emailRegex)
        let isEmail = emailPredicate.evaluate(with: text)
        return isEmail
    }
    
    /// This method is used to validate mobile number.
   public static func validateMobile(_ text:String) -> Bool{
        let mobilePredicate = NSPredicate(format: Regex.selfMatchFormat, Regex.mobileRegex)
        let isMobile = mobilePredicate.evaluate(with: text)
        return isMobile
    }
    
    /// This method is used to download the image
   public static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
         URLSession.shared.dataTask(with: url) { data, _, error in
             if let data = data {
                 completion(UIImage(data: data))
             } else {
                 completion(nil)
             }
         }.resume()
     }
    /// This method is used to open the sharesheet for sharing the message
   public static func openShareSheet(activityItem: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = nil){
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
       activityViewController.excludedActivityTypes = excludedActivityTypes
        // Present the share sheet
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
