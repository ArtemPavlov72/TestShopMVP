//
//  HeaderCell.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 06.04.2023.
//

import UIKit

protocol HeaderCellViewModelRepresentable {
    var viewModel: HeaderCellViewModelProtocol? { get }
}

class HeaderViewCell: UICollectionViewCell, HeaderCellViewModelRepresentable {
    var viewModel: HeaderCellViewModelProtocol? {
        didSet {
            updateHeaderView()
        }
    }
    
    //MARK: - Public Properties
    private let categoryLabel = UILabel()
    
    
    private func updateHeaderView() {
        //сначала извлекает опциональное значение из вьюмодел
        guard let viewModel = viewModel as? HeaderCellViewModel else { return }
      
        categoryLabel.text = viewModel.categoryName
    }
    
    //MARK: - Static Properties
    static let reuseId: String = "header"
    
  
    
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
    func configureSelectedAppearance() {
        layer.backgroundColor = UIColor.systemRed.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 0
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
