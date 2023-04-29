//
//  HeaderViewInteractor.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 19.04.2023.
//

import Foundation

protocol HeaderViewInteractorInputProtocol {
    func getCategories()
    init(presenter: HeaderViewInteractorOutputProtocol)
}

protocol HeaderViewInteractorOutputProtocol: AnyObject {
    func categoriesDidReceive(with dataStore: CategoriesListDataStore)
}

class HeaderViewInteractor: HeaderViewInteractorInputProtocol {
    
    unowned let presenter: HeaderViewInteractorOutputProtocol
    
    required init(presenter: HeaderViewInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getCategories() {
        //тестовый метод заглушка, потом переделать для получения данных из MainView
        var testProducts: [Product] = []
        
        DataManager.shared.createTestProducts(completion: { products in
            
            testProducts = products
            testProducts.sort(by: { $0.category < $1.category })
            let categories = Array(NSOrderedSet(array: testProducts.compactMap {
                $0.category
            } )) as? [String] ?? []
            let dataStore = CategoriesListDataStore(categories: categories)
            self.presenter.categoriesDidReceive(with: dataStore)
        })
    }
}

    

