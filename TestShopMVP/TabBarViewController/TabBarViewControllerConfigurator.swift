//
//  TabBarViewConfigurator.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 26.04.2023.
//

protocol TabBarViewControllerConfiguratorInputProtocol {
    func configure(with viewController: TabBarViewController)
}

class TabBarViewControllerConfigurator: TabBarViewControllerConfiguratorInputProtocol {
    func configure(with viewController: TabBarViewController) {
        let presenter = TabBarViewControllerPresenter(view: viewController)
        let interactor = TabBarViewControllerInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        
    }
}
