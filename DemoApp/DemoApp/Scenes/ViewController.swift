//
//  ViewController.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        configureButton()
    }

    func configureButton() {
        let button = UIButton(frame: CGRect(
            origin: CGPoint(x: self.view.center.x - 100, y: self.view.center.y - 25),
            size: CGSize(width: 200, height: 50)))
        button.backgroundColor = .red

        self.view.addSubview(button)
    }
}

