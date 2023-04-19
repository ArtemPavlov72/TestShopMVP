//
//  HeaderCellViewModel.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 18.04.2023.
//

import Foundation

protocol HeaderCellViewModelProtocol {
    var cellIdentifier: String { get } //индификатор ячейки
    var categoryName: String { get }
    init(category: String) //чтобы мы могли сюда передать какие-то значения, нам нужен объект данных course с типом Course
}

class HeaderCellViewModel: HeaderCellViewModelProtocol {
    var cellIdentifier: String {
        "HeaderCell"
    }
    
    var categoryName: String
    
    required init(category: String) {
        self.categoryName = category
    }
    
    
}


