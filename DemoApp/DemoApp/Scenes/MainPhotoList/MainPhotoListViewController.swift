//
// MainPhotoListViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit
import PureLayout
import Reachability

protocol MainPhotoListViewControllerProtocol: class, UIViewControllerRouting {
    var viewModel: MainPhotoListViewModelProtocol? { get }

    func set(viewModel: MainPhotoListViewModelProtocol)
    func set(router: MainPhotoListRouterProtocol)
    func endRefreshing()
    func reloadTableView()
}

class MainPhotoListViewController: UIViewController, MainPhotoListViewControllerProtocol {

    // MARK: DI
    private (set) var viewModel: MainPhotoListViewModelProtocol?
    private (set) var router: MainPhotoListRouterProtocol?

    func set(viewModel: MainPhotoListViewModelProtocol) {
        self.viewModel = viewModel
    }

    func set(router: MainPhotoListRouterProtocol) {
        self.router = router
    }

    // MARK: Properties
    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    private var loadingOverlay: UIView!

    private var reachability: Reachability!

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureReachability()
        initialSetup()
        prepareTableView()
        viewModel?.fetchPhotos()
        addLoadingOverlay()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        reachability.stopNotifier()
    }
}

// MARK: Configure Methods
extension MainPhotoListViewController {

    func configureReachability() {
        reachability = try? Reachability()

        reachability?.whenReachable = { reachability in
            Micro.log("Internet connection is on")
        }
        reachability?.whenUnreachable = { [weak self] _ in
            self?.viewModel?.handleReachabilityError()
        }
    }

    func initialSetup() {
        self.view.backgroundColor = R.color.appTertiaryV3()!
        self.title = "Photo List"

        refreshControl = UIRefreshControl()
        refreshControl.tintColor = R.color.appSecondary()!
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Photos...")
    }

    func prepareTableView() {
        tableView = UITableView()
        tableView.backgroundColor = R.color.appTertiaryV3()!

        self.view.addSubview(tableView)

        tableView.autoPinEdge(toSuperviewSafeArea: .top)
        tableView.autoPinEdge(toSuperviewSafeArea: .bottom)
        tableView.autoPinEdge(toSuperviewSafeArea: .leading)
        tableView.autoPinEdge(toSuperviewSafeArea: .trailing)

        tableView.delegate = self
        tableView.dataSource = viewModel?.dataSource

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)

        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: ReuseIdentifiers.mainPhotoList.rawValue)
    }

    @objc func refreshTableView() {
        viewModel?.fetchPhotos()
    }
}

// MARK: Methods
extension MainPhotoListViewController {

    func reloadTableView() {
        tableView.reloadData()
        self.refreshControl.endRefreshing()
        removeLoadingOverlay()
    }

    func endRefreshing() {
        self.refreshControl.endRefreshing()
        removeLoadingOverlay()
    }

    func addLoadingOverlay() {
        loadingOverlay = UIView(forAutoLayout: ())
        loadingOverlay.backgroundColor = R.color.appTransparentBlack()!
        self.view.addSubview(loadingOverlay)

        loadingOverlay.autoPinEdge(toSuperviewSafeArea: .top)
        loadingOverlay.autoPinEdge(toSuperviewSafeArea: .bottom)
        loadingOverlay.autoPinEdge(toSuperviewSafeArea: .trailing)
        loadingOverlay.autoPinEdge(toSuperviewSafeArea: .leading)

          let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loadingOverlay.addSubview(activityIndicator)
        activityIndicator.autoCenterInSuperview()

        activityIndicator.startAnimating()
    }

    func removeLoadingOverlay() {
        loadingOverlay.removeFromSuperview()
    }
}

// Table View Delegate
extension MainPhotoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = viewModel?.getPhoto(at: indexPath.row) else { return assertionFailure() }
        router?.route(to: .photoDetail(photo: photo))
    }
}
