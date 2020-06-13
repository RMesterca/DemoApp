//
//  SharedAssembly.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

class SharedAssembly: Assembly {
    let sharedContainer = Container()

    func assemble(container: Container) {
        container.register(UIApplicationProtocol.self) { _ in UIApplication.shared }

        container.register(RootNavigatorProtocol.self) { resolver in
            return RootNavigator(application: resolver ~> UIApplicationProtocol.self)
        }
    }
}
