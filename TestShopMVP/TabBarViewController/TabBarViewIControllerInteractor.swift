//
//  TabBarViewInteractor.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 26.04.2023.
//

protocol TabBarViewControllerInteractorInputProtocol {
    func getTabBarItems()
    init(presenter: TabBarViewControllerInteractorOutputProtocol)
}

protocol TabBarViewControllerInteractorOutputProtocol: AnyObject {
    func tabBarItemsDidReceive(with dataStore: TabBarItemsDataStore)
}

class TabBarViewControllerInteractor: TabBarViewControllerInteractorInputProtocol {
    
    unowned let presenter: TabBarViewControllerInteractorOutputProtocol
    
    required init(presenter: TabBarViewControllerInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getTabBarItems() {
        let dataStore = TabBarItemsDataStore(items: TabBarItem.allCases)
        self.presenter.tabBarItemsDidReceive(with: dataStore)
    }
}
