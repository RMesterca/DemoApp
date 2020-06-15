//
//  MainPhotoListDataSource.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol PhotoDataSourceProtocol: UITableViewDataSource {
    var data: [Photo] { get }

    func set(data: [Photo])
}

class PhotoDataSource: NSObject, PhotoDataSourceProtocol {

    var data: [Photo] = []

    func set(data: [Photo]) {
        self.data = data
    }
}

// MARK: UITableViewDataSource
extension PhotoDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReuseIdentifiers.mainPhotoList.rawValue,
            for: indexPath) as? PhotoTableViewCell else {
                assertionFailure()
                return UITableViewCell()
        }

        cell.configure(photo: data[indexPath.row])

        return cell
    }
}
