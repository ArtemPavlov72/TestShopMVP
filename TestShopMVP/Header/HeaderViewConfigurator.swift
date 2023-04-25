//
//  HeaderViewConfigurator.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 19.04.2023.
//

import Foundation

protocol HeaderViewConfiguratorInputProtocol {
    func configure(with viewController: HeaderView)
}

class HeaderViewConfigurator: HeaderViewConfiguratorInputProtocol {
    func configure(with viewController: HeaderView) {
        let presenter = HeaderViewPresenter(view: viewController)
        let interactor = HeaderViewInteractor(presenter: presenter)
        let router = HeaderViewRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
