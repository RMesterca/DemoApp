//
//  TopViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

protocol TopViewControllerProviderProtocol {
    func topViewController() -> UIViewControllerRouting?
}

class TopViewControllerProvider: TopViewControllerProviderProtocol {

    private let application: UIApplicationProtocol

    init(application: UIApplicationProtocol) {
        self.application = application
    }

    func topViewController() -> UIViewControllerRouting? {
        return application.topViewController(controller: nil)
    }
}
