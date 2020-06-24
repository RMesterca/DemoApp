//
//  RootNavigator.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//
import UIKit
import Swinject

protocol RootNavigatorProtocol {
    func setInitialViewController()
    func assembler() -> Container
}

class RootNavigator: RootNavigatorProtocol {

    private var application: UIApplicationProtocol
    private let sharedContainer: Container

    init(
        application: UIApplicationProtocol,
        sharedContainer: Container
    ) {
        self.application = application
        self.sharedContainer = sharedContainer
    }

    func setInitialViewController() {
        guard let initialVC = sharedContainer.resolve(MainPhotoListViewController.self) as? MainPhotoListViewController
            else { return assertionFailure() }
        application.rootViewController = ApplicationNavigationController(rootViewController: initialVC)
    }

    func assembler() -> Container {
        return sharedContainer
    }
}
