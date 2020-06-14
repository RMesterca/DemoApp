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

        tableView.autoPinEdge(.top, to: .top, of: self.view)
        tableView.autoPinEdge(.bottom, to: .bottom, of: self.view)
        tableView.autoPinEdge(.leading, to: .leading, of: self.view)
        tableView.autoPinEdge(.trailing, to: .trailing, of: self.view)

        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.mainPhotoList.rawValue)

        tableView.delegate = self
        tableView.dataSource = viewModel?.dataSource
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: Methods
extension MainPhotoListViewController {

    func reloadTableView() {
        tableView.reloadData()
    }
}

// Table View Delegate
extension MainPhotoListViewController: UITableViewDelegate {


//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }

}
