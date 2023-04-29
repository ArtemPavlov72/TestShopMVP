//
//  MainViewControllerConfigurator.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 29.04.2023.
//

protocol MainViewControllerConfiguratorInputProtocol {
    func configure(with viewController: MainViewController)
}

class MainViewConfigurator: MainViewControllerConfiguratorInputProtocol {
    func configure(with viewController: MainViewController) {
        let presenter = MainViewControllerPresenter(view: viewController)
        let interactor = MainViewControllerInteractor(presenter: presenter)
        let router = MainViewRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
