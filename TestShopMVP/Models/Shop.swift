//
//  Shop.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 04.04.2023.
//

import Foundation

struct Product: Decodable, Hashable {
    let category: String
    let name: String
    let price: Double
    let image: String
}

struct Latest: Decodable, Hashable {
    let latest: [DataProduct]
}

struct Sale: Decodable, Hashable {
    let flash_sale: [DataProduct]
}

struct DataProduct: Decodable, Hashable {
    let category: String
    let name: String
    let price: Double
    let image_url: String
}

struct Banner: Hashable {
    let bannerName: String
}

enum Link: String, CaseIterable {
    case latest = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
    case sale = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
}
