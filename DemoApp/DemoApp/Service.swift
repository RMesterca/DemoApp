//
//  Service.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

typealias RequestCompletion<T> = (Result<T, Error>) -> Void

protocol ServiceProtocol {

}

class Service {

    func getPhotos(_ completion: RequestCompletion<[Photo]>) {

    }

    func getComments(id: Int, _ completion: RequestCompletion<[Photo]>) {

    }
}
