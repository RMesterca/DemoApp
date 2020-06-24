//
//  MainPhotoListRouter.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

protocol MainPhotoListRouterProtocol {
    func set(viewController: MainPhotoListViewControllerProtocol)
    func route(to scene: MainPhotoListRouter.Scene)
}

class MainPhotoListRouter: MainPhotoListRouterProtocol {

    weak var viewController: MainPhotoListViewControllerProtocol?
    private let rootNavigator: RootNavigatorProtocol

    init(rootNavigator: RootNavigatorProtocol) {
        self.rootNavigator = rootNavigator
    }

    func set(viewController: MainPhotoListViewControllerProtocol) {
        self.viewController = viewController
    }

    enum Scene {
        case photoDetail(photo: Photo)
    }

    func route(to scene: MainPhotoListRouter.Scene) {
        switch scene {
        case .photoDetail(let photo):

            let container = rootNavigator.assembler()

            guard let vc = container.resolve(PhotoDetailViewController.self) else { return assertionFailure() }

            vc.set(data: photo)
            viewController?.show(vc, sender: nil)
        }
    }
}
