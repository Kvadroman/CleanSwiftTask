//
//  AppAssembly.swift
//  CleanSwiftTask
//
//  Created by Anton Ivchenko on 07.04.2025.
//

import Swinject

final class AppAssembly {
    let container: Container = {
        let container = Container()

        // Register network service
        container.register(PNetworkService.self) { _ in NetworkService() }

        // Register file manager service
        container.register(PFileManagerService.self) { _ in FileManagerService() }

        // Register storage service
        container.register(PStorageService.self) { resolver in
            let fileManagerService = resolver.resolve(PFileManagerService.self)!
            return StorageService(containerName: "CleanSwiftTask", fileManagerService: fileManagerService)
        }

        // Register repository
        container.register(PListRepository.self) { resolver in
            let networkService = resolver.resolve(PNetworkService.self)!
            let storageService = resolver.resolve(PStorageService.self)!
            return ListRepository(networkService: networkService, storageService: storageService)
        }

        // Register Presenter
        container.register(PListPresenterInput.self) { _ in ListPresenter() }

        // Register Interactor
        container.register(PListInteractor.self) { resolver in
            let interactor = ListInteractor()
            interactor.repository = resolver.resolve(PListRepository.self)
            // Здесь Presenter будет назначен позже, когда мы соберём модуль
            return interactor
        }

        // Register Router
        container.register(PListRouter.self) { _ in ListRouter() }

        // Register ViewController
        container.register(ListViewController.self) { resolver in
            let viewController = ListViewController()
            let interactor = resolver.resolve(PListInteractor.self)
            let router = resolver.resolve(PListRouter.self)
            let presenter = resolver.resolve(PListPresenterInput.self) as! ListPresenter
            viewController.interactor = interactor
            viewController.router = router
            presenter.viewController = viewController
            (interactor as? ListInteractor)?.presenter = presenter
            (router as? ListRouter)?.viewController = viewController
            return viewController
        }
        return container
    }()
}

