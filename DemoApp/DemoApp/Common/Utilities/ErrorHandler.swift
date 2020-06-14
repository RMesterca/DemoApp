//
//  ErrorHandler.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

protocol ErrorHandlerProtocol {
    func handle(_ error: Error)
}

// Note: - can be expanded to handle Firebase Crashlytics reporting
class ErrorHandler: ErrorHandlerProtocol {

    private let alertPresenter: AlertPresenterProtocol

    init(alertPresenter: AlertPresenterProtocol) {
        self.alertPresenter = alertPresenter
    }

    // TO DO: localize strings
    func handle(_ error: Error) {
        Micro.logError(error.localizedDescription)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertPresenter.presentAlert(
            title: "Something went wrong",
            description: error.localizedDescription,
            actions: [okAction])
    }
}
