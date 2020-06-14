//
//  PhotoDetailViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerProtocol {
}

extension PhotoDetailViewControllerProtocol {

    func instantiateViewController() -> PhotoDetailViewController {
        return PhotoDetailViewController()
    }
}


class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
