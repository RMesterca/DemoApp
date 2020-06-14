//
//  UIApplication.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol UIApplicationProtocol {
    var rootViewController: UIViewController? { get set }

    func topViewController(controller: UIViewController?) -> UIViewController?
}

extension UIApplication: UIApplicationProtocol {

    var rootViewController: UIViewController? {
        get {
            if #available(iOS 13, *) {
                return windows.first { $0.isKeyWindow }?.rootViewController
            } else {
                return keyWindow?.rootViewController
            }
        }
        set {
            if #available(iOS 13, *) {
                windows.first { $0.isKeyWindow }?.rootViewController = newValue
            } else {
                keyWindow?.rootViewController = newValue             }
        }
    }

    func topViewController(controller: UIViewController?) -> UIViewController? {
        var base: UIViewController?

        base = controller == nil ? rootViewController : controller

        if let navigationController = base as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }

        if let presented = base?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return base
    }
}
