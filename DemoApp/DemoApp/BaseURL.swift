//
//  BaseURL.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

enum BaseURL {

    enum Environment {
        case dev
        case staging
    }

    static var apiURL: String {
        guard let env = ProcessInfo.processInfo.environment["environment"]
            else { assertionFailure(); return "" }

        // normally, there would be separate environments
        switch env {
        case "dev", "staging":
            return "https://jsonplaceholder.typicode.com"

        default:
            assertionFailure("undefined environment")
            return ""
        }
    }
}
