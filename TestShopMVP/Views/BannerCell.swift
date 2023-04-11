//
//  BannerCell.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 04.04.2023.
//

import UIKit

class BannerCell: UICollectionViewCell, SelfConfiguringCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "banner"
    
    //MARK: - Private Properties
    private let icon: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
        
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(icon)
        setupSubViews(icon)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
    func configure(with data: Any) {
        guard let bannerData = data as? Banner else { return }
        icon.image = UIImage(named: bannerData.bannerName)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        icon.heightAnchor.constraint(equalToConstant: 120).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
