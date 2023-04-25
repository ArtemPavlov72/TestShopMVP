//
//  HeaderViewCell.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 06.04.2023.
//

import UIKit

protocol HeaderCellViewModelRepresentable {
    var viewModel: HeaderCellViewModelProtocol? { get }
}

class HeaderViewCell: UICollectionViewCell, HeaderCellViewModelRepresentable {
    
    //MARK: - Static Properties
   // static let reuseId: String = "header"
    
    //MARK: - Public Properties
    var viewModel: HeaderCellViewModelProtocol? {
        didSet {
            updateHeaderView()
        }
    }
    
    //MARK: - Private Properties
    private let categoryLabel = UILabel()
    
    //MARK: - Cell Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(categoryLabel)
        setupSubViews(categoryLabel)
        setupConstraints()
        setupViewLayer()
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
        layer.borderWidth = 1
        categoryLabel.textColor = UIColor.black
        categoryLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    //MARK: - Private Methods
    private func updateHeaderView() {
        categoryLabel.text = viewModel?.categoryName
    }
    
    private func setupViewLayer() {
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 20
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
