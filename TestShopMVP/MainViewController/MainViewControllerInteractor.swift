//
//  MainViewControllerInteractor.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 29.04.2023.
//

protocol MainViewControllerInteractorInputProtocol {
    init(presenter: MainViewControllerInteractorOutputProtocol)
}

protocol MainViewControllerInteractorOutputProtocol: AnyObject {
    
}

class MainViewControllerInteractor: MainViewControllerInteractorInputProtocol {
    
    unowned let presenter: MainViewControllerInteractorOutputProtocol
    
    required init(presenter: MainViewControllerInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    
}
