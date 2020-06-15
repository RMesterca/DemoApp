//
//  PhotoListRouter.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

protocol PhotoDetailRouterProtocol {
    func set(viewController: PhotoDetailViewControllerProtocol)
    func route(to scene: PhotoDetailRouter.Scene)
}

class PhotoDetailRouter: PhotoDetailRouterProtocol {

    weak var viewController: PhotoDetailViewControllerProtocol?

    func set(viewController: PhotoDetailViewControllerProtocol) {
        self.viewController = viewController
    }

    enum Scene {
        case mainPhotoList
    }

    func route(to scene: PhotoDetailRouter.Scene) {
        switch scene {
        case .mainPhotoList:
            viewController?.pop(animated: true)
        }
    }
}
