//
//  ApplicationNavigationController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

class ApplicationNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Privates
private extension ApplicationNavigationController {

    func setup() {

        if let font = R.font.metalManiaRegular(size: 30) {
            navigationBar.titleTextAttributes = [
                .foregroundColor: R.color.appTertiaryV3()!,
                .font: font
            ]
        }

        navigationBar.barTintColor = R.color.appPrimary()!
        navigationBar.backIndicatorImage = R.image.backArrow()!
        navigationBar.backIndicatorTransitionMaskImage = R.image.icons8GoBack504()!

        navigationBar.tintColor = R.color.appSecondary()!
    }
}
