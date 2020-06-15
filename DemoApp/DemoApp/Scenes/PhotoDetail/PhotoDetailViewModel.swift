//
//  PhotoDetailViewModel.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

protocol PhotoDetailViewModelProtocol {
    var dataSource: PhotoDetailDataSourceProtocol? { get }
    var photo: Photo? { get }

    func set(viewController: PhotoDetailViewControllerProtocol?)
    func set(dataSource: PhotoDetailDataSourceProtocol)
    func set(photo: Photo)

    func fetchComments()
}

class PhotoDetailViewModel: PhotoDetailViewModelProtocol {

    weak var viewController: PhotoDetailViewControllerProtocol?
    private let service: ServiceProtocol
    private let errorHandler: ErrorHandlerProtocol

    private (set) var dataSource: PhotoDetailDataSourceProtocol?
    private (set) var photo: Photo?

    init(
        service: ServiceProtocol,
        errorHandler: ErrorHandlerProtocol
    ) {
        self.service = service
        self.errorHandler = errorHandler
    }

    func set(viewController: PhotoDetailViewControllerProtocol?) {
        self.viewController = viewController
    }

    func set(dataSource: PhotoDetailDataSourceProtocol) {
        self.dataSource = dataSource
    }
}

// MARK: Methods
extension PhotoDetailViewModel {

    func set(photo: Photo) {
        self.photo = photo
    }

    func fetchComments() {
        guard let id = photo?.id else { return assertionFailure() }

        resetComments()

        service.getComments(id: id) { [weak self] result in
            switch result {
            case .success(let comments):
                Micro.logSuccess("\(comments)")
                self?.dataSource?.set(data: Array(comments.prefix(20)))
                self?.viewController?.reloadTableView()
            case .failure(let error):
                self?.viewController?.endRefreshing()
                self?.errorHandler.handle(error)
            }
        }
    }

    func resetComments() {
        dataSource?.set(data: [])
        viewController?.reloadTableView()
    }
}
