//
//  File.swift
//
//
//  Created by Satyam Tripathi on 18/12/23.
//

import Foundation
import UIKit

/**
 A collection of utility methods for common tasks such as image loading and sharing messages.
 */
public class Utilities: NSObject {
    
    /**
     Downloads an image from the specified URL asynchronously.
     
     - Parameters:
     - url: The URL of the image to download.
     - completion: A closure to be executed when the image download is complete, returning the downloaded UIImage or nil if an error occurs.
     */
    public static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    /**
     Opens a share sheet for sharing a message with other apps.
     
     - Parameters:
     - activityItem: The message to be shared.
     - excludedActivityTypes: An optional array of UIActivity.ActivityType to exclude from the share sheet.
     */
    public static func openShareSheet(activityItem: String, excludedActivityTypes: [UIActivity.ActivityType]? = nil){
        let activityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
        activityViewController.excludedActivityTypes = excludedActivityTypes
        // Present the share sheet
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
