//
//  File.swift
//
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import UIKit

public class Utilities: NSObject {
    
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
   public static func openShareSheet(activityItem: String, excludedActivityTypes: [UIActivity.ActivityType]? = nil){
        let activityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
       activityViewController.excludedActivityTypes = excludedActivityTypes
        // Present the share sheet
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
