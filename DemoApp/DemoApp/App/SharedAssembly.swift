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
            return RootNavigator(
                application: resolver ~> UIApplicationProtocol.self,
                initialViewController: resolver ~> (MainPhotoListViewControllerProtocol.self))
        }

        container.register(ServiceProtocol.self) { resolver in
            return Service(client: AlamofireClient<DemoAppTarget>())
        }

        container.register(MainPhotoListViewControllerProtocol.self) { resolver in
            let vc =  MainPhotoListViewController()
            vc.set(viewModel: resolver ~> MainPhotoListViewModelProtocol.self)
            return vc
        }

        container.autoregister(MainPhotoListViewModelProtocol.self, initializer: MainPhotoListViewModel.init)
    }
}
