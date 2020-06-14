//
//  RouterProtocol.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

enum Scene {
    case mainPhotoList
    case photoDetail
}

protocol Router {
    func route(to destination: Scene, from scene: Scene)
}
