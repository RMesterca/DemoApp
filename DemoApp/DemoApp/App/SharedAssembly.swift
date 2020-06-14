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

        // UIApplication
        container.register(UIApplicationProtocol.self) { _ in UIApplication.shared }

        // Top View Controller Provider
        container.autoregister(TopViewControllerProviderProtocol.self, initializer: TopViewControllerProvider.init)

        // Root
        container.register(RootNavigatorProtocol.self) { resolver in
            return RootNavigator(
                application: resolver ~> UIApplicationProtocol.self,
                initialViewController: resolver ~> (MainPhotoListViewControllerProtocol.self))
        }

        // Alert presenter
        container.autoregister(AlertPresenterProtocol.self, initializer: AlertPresenter.init)

        // Error Handler
        container.autoregister(ErrorHandlerProtocol.self, initializer: ErrorHandler.init)

        // Service
        container.register(ServiceProtocol.self) { resolver in
            return Service(client: AlamofireClient<DemoAppTarget>())
        }

        // Main Scene
        container.register(MainPhotoListViewControllerProtocol.self) { resolver in
            let vc = MainPhotoListViewController()
            let viewModel = resolver ~> MainPhotoListViewModelProtocol.self
            let dataSource = resolver ~> PhotoDataSourceProtocol.self

            vc.set(viewModel: viewModel)

            viewModel.set(viewController: vc)
            viewModel.set(dataSource: dataSource)

            return vc
        }

        container.autoregister(PhotoDataSourceProtocol.self, initializer: PhotoDataSource.init)

        container.autoregister(MainPhotoListViewModelProtocol.self, initializer: MainPhotoListViewModel.init)

        // Detail Scene
    }
}
