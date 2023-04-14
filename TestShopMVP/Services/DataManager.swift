//
//  DataManager.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 04.04.2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    // MARK: - Banner Data
    private func getFakeBannersData() -> [String] {
        return ["sale1", "sale2", "sale3"]
    }
    
    func createBanners() -> [Banner] {
        var banners: [Banner] = []
        
        let _ = getFakeBannersData().map { banner in
            let newBanner = Banner(bannerName: banner)
            banners.append(newBanner)
        }
        
        return banners
    }
    
    // MARK: - Product Data
    private func createLatestProducts(completion: @escaping (Latest) -> Void) {
        NetworkManager.shared.fetchData(dataType: Latest.self, from: Link.latest.rawValue) { result in
            switch result {
            case.success(let product):
                completion(product)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    private func createSaleProducts(completion: @escaping (Sale) -> Void) {
        NetworkManager.shared.fetchData(dataType: Sale.self, from: Link.sale.rawValue) { result in
            switch result {
            case.success(let product):
                completion(product)
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func createTestProducts(completion: @escaping ([Product]) -> Void) {
        var products: [Product] = []
        var dataProducts: [DataProduct] = []
        var id: Int = 0
        let group = DispatchGroup()
        
        group.enter()
        createLatestProducts(completion: { product in
            dataProducts.append(contentsOf: product.latest)
            group.leave()
        })
        
        group.enter()
        createLatestProducts(completion: { product in
            dataProducts.append(contentsOf: product.latest)
            group.leave()
        })
        
        group.enter()
        createLatestProducts(completion: { product in
            dataProducts.append(contentsOf: product.latest)
            group.leave()
        })
        
        group.enter()
        createLatestProducts(completion: { product in
            dataProducts.append(contentsOf: product.latest)
            group.leave()
        })
        
        group.enter()
        createSaleProducts(completion: { product in
            dataProducts.append(contentsOf: product.flash_sale)
            group.leave()
        })
        
        group.enter()
        createSaleProducts(completion: { product in
            dataProducts.append(contentsOf: product.flash_sale)
            group.leave()
        })
        
        group.notify(queue: .main) {
            _ = dataProducts.map { product in
                let newProduct = Product(
                    id: id + 1,
                    category: product.category,
                    name: product.name,
                    price: product.price,
                    image: product.image_url
                )
                id += 1
                products.append(newProduct)
            }
            completion(products)
        }
    }
}
