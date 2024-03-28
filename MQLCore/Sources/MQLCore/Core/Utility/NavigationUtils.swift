//
//  File.swift
//  
//
//  Created by Satyam Tripathi on 19/12/23.
//

import Foundation
import UIKit

/**
 A utility struct providing navigation-related functions for managing view controllers in the navigation stack.

 NavigationUtils encapsulates functionality to pop back to the root view controller and search for a specific view controller within the navigation stack.
 */
public struct NavigationUtils {
    
    /**
     Pops back to the root view controller in the navigation stack.
     
     - Parameter animated: A boolean indicating whether the transition should be animated. Default is false.
     */
    public static func popToRootView(animated: Bool = false) {
        findNavigationController(viewController: UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController)?.popToRootViewController(animated: animated)
    }
    
    /**
     Searches for a specific view controller within the navigation stack.
     
     - Parameter viewController: The view controller to start the search from.
     - Returns: The navigation controller containing the specified view controller, if found; otherwise, returns nil.
     */
    public static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UITabBarController {
            return findNavigationController(viewController: navigationController.selectedViewController)
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}
