//
//  ConnectivityProtocol.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 15/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Connectivity

protocol ConnectivityProtocol {
    func checkConnectivity(completion: ((Connectivity) -> Void)?)
}

extension ConnectivityProtocol {

    func connectivity(_ completion: @escaping (Error?) -> Void) {
        checkConnectivity { connectivity in
            switch connectivity.status {
            case .connected, .connectedViaWiFi, .connectedViaCellular:
                completion(nil)
            case .determining: break // ??
            default:
                completion(AppError.noConnection)
            }
        }
    }
}

extension Connectivity: ConnectivityProtocol {}
