//
//  SharedAssembly.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 13/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import Connectivity

// swiftlint:disable function_body_length
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

        // Connectivity
        container.register(ConnectivityProtocol.self) { _ in
            let connectivity = Connectivity()
            connectivity.connectivityURLs = [URL(string: "https://www.apple.com/library/test/success.html")!]
            return connectivity
        }

        // Service
        container.register(ServiceProtocol.self) { _ in
            return Service(client: AlamofireClient<DemoAppTarget>())
        }

        // Main Scene
        container.register(MainPhotoListViewControllerProtocol.self) { resolver in
            let vc = MainPhotoListViewController()

            let router = resolver ~> MainPhotoListRouterProtocol.self
            let viewModel = resolver ~> MainPhotoListViewModelProtocol.self
            let dataSource = resolver ~> PhotoDataSourceProtocol.self

            viewModel.set(viewController: vc)
            viewModel.set(dataSource: dataSource)

            router.set(viewController: vc)

            vc.set(viewModel: viewModel)
            vc.set(router: router)

            return vc
        }

        container.autoregister(PhotoDataSourceProtocol.self, initializer: PhotoDataSource.init)
        container.autoregister(MainPhotoListViewModelProtocol.self, initializer: MainPhotoListViewModel.init)
        container.autoregister(MainPhotoListRouterProtocol.self, initializer: MainPhotoListRouter.init)

        // Detail Scene
        container.register(PhotoDetailViewControllerProtocol.self) { resolver in
            let vc = PhotoDetailViewController()

            let router = resolver ~> PhotoDetailRouterProtocol.self
            let viewModel = resolver ~> PhotoDetailViewModelProtocol.self
            let dataSource = resolver ~> PhotoDetailDataSourceProtocol.self

            viewModel.set(viewController: vc)
            viewModel.set(dataSource: dataSource)

            router.set(viewController: vc)

            vc.set(viewModel: viewModel)
            vc.set(router: router)

            return vc
        }

        container.autoregister(PhotoDetailDataSourceProtocol.self, initializer: PhotoDetailDataSource.init)
        container.autoregister(PhotoDetailViewModelProtocol.self, initializer: PhotoDetailViewModel.init)
        container.autoregister(PhotoDetailRouterProtocol.self, initializer: PhotoDetailRouter.init)
    }
}
// swiftlint:enable function_body_length
