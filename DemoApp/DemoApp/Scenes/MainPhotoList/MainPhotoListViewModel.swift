//
//  MainPhotoListViewModel.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//


protocol MainPhotoListViewModelProtocol {
     func makeRequest()
}

class MainPhotoListViewModel: MainPhotoListViewModelProtocol {

    private let service: ServiceProtocol

    init(service: ServiceProtocol) {
        self.service = service
    }

    func makeRequest() {
        service.getPhotos { [weak self] result in
            switch result {
            case .success(let photos):

                debugPrint(photos)
            case .failure(let error):
                break
                //handle error case
            }
        }
    }

}
