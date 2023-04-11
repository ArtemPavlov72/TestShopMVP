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
        self.backgroundColor = .yellow
        setupElements(categoryLabel)
        setupSubViews(categoryLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configureCell(with category: String) {
        categoryLabel.text = category
    }
    
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}
