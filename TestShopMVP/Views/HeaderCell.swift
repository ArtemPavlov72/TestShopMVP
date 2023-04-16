//
//  HeaderCell.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 06.04.2023.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "header"
    
    //MARK: - Public Properties
    private let categoryLabel = UILabel()
    
    //MARK: - Cell Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(categoryLabel)
        setupSubViews(categoryLabel)
        setupConstraints()
        
        layer.borderColor = UIColor.systemRed.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configureCell(with category: String) {
        categoryLabel.text = category
    }
    
    func configureSelectedAppearance() {
        layer.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2).cgColor
          layer.borderWidth = 0
         // layer.cornerRadius = 20
        categoryLabel.textColor = UIColor.systemRed
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 16)
      }

    func configureStandartAppearance() {
      layer.backgroundColor = .none
      layer.borderColor = UIColor.systemRed.cgColor
      layer.borderWidth = 1
      categoryLabel.textColor = UIColor(named: "FD3A69")
      categoryLabel.font = UIFont.systemFont(ofSize: 16)

    }
    
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}
