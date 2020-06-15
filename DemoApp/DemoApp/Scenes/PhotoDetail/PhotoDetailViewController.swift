//
//  PhotoDetailViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerProtocol: class, UIViewControllerRouting {
    var viewModel: PhotoDetailViewModelProtocol? { get }

    func set(viewModel: PhotoDetailViewModelProtocol)
    func set(router: PhotoDetailRouterProtocol)
    func set(data: Photo)

    func reloadTableView()
    func endRefreshing()
}

// icons by Icons8
class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerProtocol {

    // MARK: DI
    private (set) var viewModel: PhotoDetailViewModelProtocol?
    private (set) var router: PhotoDetailRouterProtocol?

    func set(viewModel: PhotoDetailViewModelProtocol) {
        self.viewModel = viewModel
    }

    func set(router: PhotoDetailRouterProtocol) {
        self.router = router
    }

    func set(data: Photo) {
        viewModel?.set(photo: data)
    }

    // MARK: Properties
    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        initialSetup()
        viewModel?.fetchComments()
    }
}

// MARK: Configure Methods
extension PhotoDetailViewController {

    func initialSetup() {
        self.view.backgroundColor = R.color.appTertiaryV3()!

        refreshControl = UIRefreshControl()
        refreshControl.tintColor = R.color.appSecondary()!
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Comments...")

        setupNavigationBar()
        prepareTableView()
    }

    func prepareTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = R.color.appTertiaryV1()!
        self.view.addSubview(tableView)

        tableView.autoPinEdge(toSuperviewSafeArea: .top)
        tableView.autoPinEdge(toSuperviewSafeArea: .bottom)
        tableView.autoPinEdge(toSuperviewSafeArea: .leading)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing)

        tableView.delegate = self
        tableView.dataSource = viewModel?.dataSource

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 300
        tableView.sectionHeaderHeight = UITableView.automaticDimension

        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)

        tableView.register(
            PhotoDetailTableViewCell.self,
            forCellReuseIdentifier: ReuseIdentifiers.photoDetailCommentList.rawValue)
        tableView.register(
            PhotoDetailHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ReuseIdentifiers.photoDetailHeaderView.rawValue)
    }

    @objc func refreshTableView() {
        viewModel?.fetchComments()
    }
}

// MARK: Methods
extension PhotoDetailViewController {

    func reloadTableView() {
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
}

// MARK: UITableViewDelegate
extension PhotoDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ReuseIdentifiers.photoDetailHeaderView.rawValue)
            as? PhotoDetailHeaderView else { assertionFailure(); return nil }

        guard let photo = viewModel?.photo else { assertionFailure(); return view }

        view.configure(with: photo)
        return view
    }
}

// MARK: Navigation Bar
extension PhotoDetailViewController {

    private func setupNavigationBar() {
        self.title = "Photo Detail"

        let image = R.image.backArrow()!.withRenderingMode(.alwaysOriginal)

        let backButton = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(PhotoDetailViewController.popToMain))
        navigationItem.leftBarButtonItems = [backButton]
    }

    @objc func popToMain() {
        router?.route(to: .mainPhotoList)
    }
}
