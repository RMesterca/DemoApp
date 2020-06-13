//
//  Comment.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

struct Comment: Codable {
    let postId, id: Int
    let name, email, body: String
}
