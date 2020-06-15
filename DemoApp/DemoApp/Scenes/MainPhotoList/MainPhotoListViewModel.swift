//
//  MainPhotoListViewModel.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

protocol MainPhotoListViewModelProtocol {
    var dataSource: PhotoDataSourceProtocol? { get }

    func set(viewController: MainPhotoListViewControllerProtocol?)
    func set(dataSource: PhotoDataSourceProtocol)

    func fetchPhotos()
    func getPhoto(at index: Int) -> Photo?
}

class MainPhotoListViewModel: MainPhotoListViewModelProtocol {

    weak var viewController: MainPhotoListViewControllerProtocol?
    private let service: ServiceProtocol
    private let errorHandler: ErrorHandlerProtocol
    private let connectivity: ConnectivityProtocol

    var dataSource: PhotoDataSourceProtocol?

    init(
        service: ServiceProtocol,
        errorHandler: ErrorHandlerProtocol,
        connectivity: ConnectivityProtocol
    ) {
        self.service = service
        self.errorHandler = errorHandler
        self.connectivity = connectivity
    }

    func set(viewController: MainPhotoListViewControllerProtocol?) {
        self.viewController = viewController
    }

    func set(dataSource: PhotoDataSourceProtocol) {
        self.dataSource = dataSource
    }
}

// MARK: Methods
extension MainPhotoListViewModel {

    func fetchPhotos() {
        connectivity.connectivity { [weak self] error in
            if let error = error {
                self?.viewController?.endRefreshing()
                self?.errorHandler.handle(error)
                return
            }

            self?.service.getPhotos { [weak self] result in
                switch result {
                case .success(let photos):
                    self?.dataSource?.set(data: photos.sorted { $0.title < $1.title })
                    self?.viewController?.reloadTableView()
                case .failure(let error):
                    self?.viewController?.endRefreshing()
                    self?.errorHandler.handle(error)
                }
            }
        }
    }

    func getPhoto(at index: Int) -> Photo? {
        guard let dataSource = dataSource, index < dataSource.data.count
            else { assertionFailure(); return nil }
        return dataSource.data[index]
    }
}
