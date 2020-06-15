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
}

class RootNavigator: RootNavigatorProtocol {

    private var application: UIApplicationProtocol
    private let initialViewController: MainPhotoListViewControllerProtocol

    init(
        application: UIApplicationProtocol,
        initialViewController: MainPhotoListViewControllerProtocol
    ) {
        self.application = application
        self.initialViewController = initialViewController
    }

    func setInitialViewController() {
        application.rootViewController = ApplicationNavigationController(rootViewController: initialViewController.toPresent())
    }
}
