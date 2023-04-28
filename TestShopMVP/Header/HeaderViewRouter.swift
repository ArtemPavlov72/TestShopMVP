//
//  HeaderViewRouter.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 19.04.2023.
//

protocol HeaderViewRouterInputProtocol {
    init(viewController: HeaderView)
}

class HeaderViewRouter: HeaderViewRouterInputProtocol {
    unowned let viewController: HeaderView
    
    required init(viewController: HeaderView) {
        self.viewController = viewController
    }
}
