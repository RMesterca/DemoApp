//
//  DemoAppTarget.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Foundation

protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
}

enum DemoAppTarget: TargetType {
    case getPhotos
    case getComments(id: Int)
    
    var baseURL: String {
        return BaseURL.apiURL
    }

    var path: String {
        switch self {
        case .getPhotos: return baseURL + "/photos"
        case .getComments(let id): return baseURL + "/photos/\(id)/comments"
        }
    }
}
