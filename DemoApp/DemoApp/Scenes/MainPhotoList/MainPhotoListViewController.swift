//
// MainPhotoListViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol MainPhotoListViewControllerProtocol {
    var viewModel: MainPhotoListViewModelProtocol? { get }

    func set(viewModel: MainPhotoListViewModelProtocol)
}

extension MainPhotoListViewControllerProtocol {

    func instantiateViewController() -> MainPhotoListViewController {
        let vc = MainPhotoListViewController()
        guard let viewModel = viewModel else { assertionFailure(); return vc }
        vc.set(viewModel: viewModel)
        return vc
    }
}

class MainPhotoListViewController: UIViewController, MainPhotoListViewControllerProtocol {

    private (set) var viewModel: MainPhotoListViewModelProtocol?

    func set(viewModel: MainPhotoListViewModelProtocol) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        viewModel?.makeRequest()
    }
}
