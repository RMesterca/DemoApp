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
        var title = "Something went wrong"
        var description = error.localizedDescription

        if let appError = error as? AppError {
            title = appError.title
            description = appError.localizedDescription
        }

        Micro.logError(description)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertPresenter.presentAlert(title: title, description: description, actions: [okAction])
    }
}
