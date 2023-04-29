//
//  TabBarViewPresenter.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 26.04.2023.
//

struct TabBarItemsDataStore {
    let items: [TabBarItem]
}

class TabBarViewControllerPresenter: TabBarViewControllerOutputProtocol {
    unowned let view: TabBarViewControllerInputProtocol
    var interactor: TabBarViewControllerInteractorInputProtocol!
    
    required init(view: TabBarViewControllerInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.getTabBarItems()
    }
}

extension TabBarViewControllerPresenter: TabBarViewControllerInteractorOutputProtocol {
    func tabBarItemsDidReceive(with dataStore: TabBarItemsDataStore) {
        view.setViewControllers(for: dataStore.items)
    }
}
