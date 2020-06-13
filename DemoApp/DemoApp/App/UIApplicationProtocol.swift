//
//  UIApplication.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol UIApplicationProtocol {
    var keyWindow: UIWindow? { get }
    var rootViewController: UIViewController? { get set }
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
}
