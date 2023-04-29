//
//  HeaderViewPresenter.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 19.04.2023.
//

import Foundation

struct CategoriesListDataStore {
    let categories: [String]
}

class HeaderViewPresenter: HeaderViewOutputProtocol {
    unowned let view: HeaderViewInputProtocol
    var interactor: HeaderViewInteractorInputProtocol!
    var router: HeaderViewRouterInputProtocol!
    
    private var dataSource: CategoriesListDataStore?
    
    required init(view: HeaderViewInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.getCategories()
    }
}

extension HeaderViewPresenter: HeaderViewInteractorOutputProtocol {
    func categoriesDidReceive(with dataStore: CategoriesListDataStore) {
        //self.dataSource = dataStore
        var categories: [HeaderCellViewModel] = []
        dataStore.categories.forEach { categories.append(HeaderCellViewModel(category: $0))
            view.reloadData(for: categories)
        }
    }
}
