//
//  PhotoDetailDataSource.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 15/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol PhotoDetailDataSourceProtocol: UITableViewDataSource {
    var data: [Comment] { get }

    func set(data: [Comment])
}

class PhotoDetailDataSource: NSObject, PhotoDetailDataSourceProtocol {

    var data: [Comment] = []

    func set(data: [Comment]) {
        self.data = data
    }
}

// MARK: UITableViewDataSource
extension PhotoDetailDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReuseIdentifiers.photoDetailCommentList.rawValue,
            for: indexPath) as? PhotoDetailTableViewCell else {
                assertionFailure()
                return UITableViewCell()
        }

        cell.configure(comment: data[indexPath.row])

        return cell
    }
}
