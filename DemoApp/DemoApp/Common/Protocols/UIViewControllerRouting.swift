//
//  UIViewControllerRouting.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//
import UIKit

protocol UIViewControllerRouting {
    func toPresent() -> UIViewController

    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func show(_ vc: UIViewController, sender: Any?)
    func pop(animated: Bool)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
    func popToRoot(animated: Bool)
}

protocol UINavigationControllerRouting {
    func popViewController(animated: Bool) -> UIViewController?
    func show(_ vc: UIViewController, sender: Any?)
}

extension UIViewController: UIViewControllerRouting {
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }

    func toPresent() -> UIViewController {
        return self
    }
}
