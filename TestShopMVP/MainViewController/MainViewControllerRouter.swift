//
//  MainViewControllerRouter.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 29.04.2023.
//

protocol MainViewControllerRouterInputProtocol {
    init(viewController: MainViewController)
}

class MainViewRouter: MainViewControllerRouterInputProtocol {
  
    

    unowned let viewController: MainViewController
    
    required init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
}

