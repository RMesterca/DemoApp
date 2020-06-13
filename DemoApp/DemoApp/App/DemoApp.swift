//
//  DemoApp.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

protocol DemoAppProtocol {
    func prepare()
}

class DemoApp: DemoAppProtocol {

    private let sharedContainer: Container
    private let sharedAssembly: Assembly
    private let rootNavigator: RootNavigatorProtocol

    init(
        sharedAssembly: Assembly,
        sharedContainer: Container
    ) {
        self.sharedAssembly = sharedAssembly
        self.sharedContainer = sharedContainer
        sharedAssembly.assemble(container: self.sharedContainer)
        rootNavigator = sharedContainer ~> RootNavigatorProtocol.self
    }

    convenience init() {
        let sharedAssembly = SharedAssembly()
        self.init(
            sharedAssembly: sharedAssembly,
            sharedContainer: sharedAssembly.sharedContainer
        )
    }

    func prepare() {
        rootNavigator.setRootViewController()
    }
}
