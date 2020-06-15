//
//  AppError.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 15/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

// TO DO: Localize strings
enum AppError: Error {

    case noConnection

    var title: String { return "Oops" }
    var localizedDescription: String { return "No internet connection. Please check your settings and try again." }
}
