//
// MainPhotoListViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit
import PureLayout

protocol MainPhotoListViewControllerProtocol: class, UIViewControllerRouting {
    var viewModel: MainPhotoListViewModelProtocol? { get }

    func set(viewModel: MainPhotoListViewModelProtocol)
    func reloadTableView()
}

//extension MainPhotoListViewControllerProtocol {
//
//    func instantiateViewController() -> MainPhotoListViewController {
//        let vc = MainPhotoListViewController()
//        guard let viewModel = viewModel else { assertionFailure(); return vc }
//        vc.set(viewModel: viewModel)
//        return vc
//    }
//}

class MainPhotoListViewController: UIViewController, MainPhotoListViewControllerProtocol {

    // icons by Icons8

    // MARK: DI
    private (set) var viewModel: MainPhotoListViewModelProtocol?

    func set(viewModel: MainPhotoListViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: Properties
    private var tableView: UITableView!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        prepareTableView()
        viewModel?.fetchPhotos()
    }
}

// MARK: Configure Methods
extension MainPhotoListViewController {

    func prepareTableView() {
        tableView = UITableView()
        self.view.addSubview(tableView)

        tableView.autoPinEdge(toSuperviewSafeArea: .top)
        tableView.autoPinEdge(toSuperviewSafeArea: .bottom)
        tableView.autoPinEdge(toSuperviewSafeArea: .leading)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing)

        tableView.delegate = self
        tableView.dataSource = viewModel?.dataSource

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.mainPhotoList.rawValue)
    }
}

// MARK: Methods
extension MainPhotoListViewController {

    func reloadTableView() {
        tableView.reloadData()
    }
}

// Table View Delegate
extension MainPhotoListViewController: UITableViewDelegate { }
