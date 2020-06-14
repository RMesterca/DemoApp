//
//  Service.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

//import Alamofire

typealias RequestCompletion<T> = (Result<T, Error>) -> Void

protocol ServiceProtocol {
    func getPhotos(_ completion: @escaping RequestCompletion<[Photo]>)
    func getComments(id: Int, _ completion: @escaping RequestCompletion<[Comment]>) 
}

class Service: ServiceProtocol {

    let client: AlamofireClient<DemoAppTarget>

    init(client: AlamofireClient<DemoAppTarget>) {
        self.client = client
    }

    func getPhotos(_ completion: @escaping RequestCompletion<[Photo]>) {
        client.request(.getPhotos, completion)
    }

    func getComments(id: Int, _ completion: @escaping RequestCompletion<[Comment]>) {
        client.request(.getComments(id: id), completion)
    }
}
