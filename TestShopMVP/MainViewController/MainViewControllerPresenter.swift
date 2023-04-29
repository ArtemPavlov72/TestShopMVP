//
//  MainViewControllerPresenter.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 29.04.2023.
//

class MainViewControllerPresenter: MainViewControllerOutputProtocol {
    
    unowned let view: MainViewControllerInputProtocol
    
    var interactor: MainViewControllerInteractorInputProtocol!
    var router: MainViewControllerRouterInputProtocol!
    
    required init(view: MainViewControllerInputProtocol) {
        self.view = view
    }
    
    
}

extension MainViewControllerPresenter: MainViewControllerInteractorOutputProtocol {
    
}
