//
//  AlertPresenter.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol AlertPresenterProtocol {
    func presentAlert(title: String?, description: String?, actions: [UIAlertAction])
    func presentActionSheet(title: String?, description: String?, actions: [UIAlertAction])
    func presentAlertAttributed(title: NSAttributedString, description: NSAttributedString, actions: [UIAlertAction])
}

class AlertPresenter: AlertPresenterProtocol {
    
    private let topViewControllerProvider: TopViewControllerProviderProtocol
    
    init(topViewControllerProvider: TopViewControllerProviderProtocol) {
        self.topViewControllerProvider = topViewControllerProvider
    }
    
    func presentActionSheet(title: String?, description: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String?, description: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            actions.forEach { alert.addAction($0) }
            self.topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentAlertAttributed(title: NSAttributedString, description: NSAttributedString, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alert.setValue(title, forKey: "attributedTitle")
            alert.setValue(description, forKey: "attributedMessage")
            actions.forEach { alert.addAction($0) }
            self.topViewControllerProvider.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
}
