//
//  ImageManager.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 04.04.2023.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func loadImage(from url: String?) -> Data? {
        guard let imageURL = URL(string: url ?? "") else {return nil}
        return try? Data(contentsOf: imageURL)
    }
}
