//
//  AlamofireClient.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation
import Alamofire

typealias Method = Alamofire.HTTPMethod

protocol AlamofireClientProtocol {
    associatedtype Target: TargetType

    func request<T: Codable>(_ target: Target, _ completion: @escaping RequestCompletion<T>)
}

class AlamofireClient<Target: TargetType>: AlamofireClientProtocol {

    private var applicationJSONDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }

    // the target can be set to allow expansion in the future
    // usually, several targets/services will need to be implemented
    func request<T: Codable>(_ target: Target, _ completion: @escaping RequestCompletion<T>) {

        AF.request(target.path)
            .validate(statusCode: 200..<300)
            .responseJSON { [weak self] response in
                guard let self = self else { return assertionFailure() }

                switch response.result {
                case .success(let data):
                    completion(Result(catching: { try self.decode(value: data ?? [:]) }))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }

    func decode<V: Codable>(value: Any) throws -> V {
        let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
        return try applicationJSONDecoder.decode(V.self, from: data)
    }
}
