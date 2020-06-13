//
//  RootNavigator.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

protocol RootNavigatorProtocol {
    func setRootViewController()
}

class RootNavigator: RootNavigatorProtocol {

private var application: UIApplicationProtocol

    init(application: UIApplicationProtocol) {
          self.application = application
      }

    func setRootViewController() {
        application.rootViewController = MainPhotoListViewController()
    }
}
