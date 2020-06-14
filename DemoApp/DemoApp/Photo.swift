//
//  Photo.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

struct Photo: Codable {
    let albumId, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumId, id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
