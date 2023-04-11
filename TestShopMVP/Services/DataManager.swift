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
    
    private func getFakeBannersData() -> [String] {
        return ["sale1", "sale2", "sale3", "sale4", "sale5"]
    }
    
    func createBanners() -> [Banner] {
        var banners: [Banner] = []
        
        let _ = getFakeBannersData().map { banner in
            let newBanner = Banner(bannerName: banner)
            banners.append(newBanner)
        }

        return banners
    }
    
    
    
}
