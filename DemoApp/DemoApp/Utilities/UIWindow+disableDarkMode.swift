//
//  UIWindow+disableDarkMode.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

extension UIWindow {

    func disableDarkMode() {
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
    }
}
