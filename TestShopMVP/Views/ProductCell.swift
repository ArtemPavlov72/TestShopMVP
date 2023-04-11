//
//  ProductCell.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 04.04.2023.
//

import UIKit

class ProductCell: UICollectionViewCell, SelfConfiguringCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "product"
    
    //MARK: - Private Properties
    private let productName = UILabel()
    private let productDescription = UILabel()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    private let productImage = UIImageView()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .leading
        stackView.spacing = 5.0
        stackView.addArrangedSubview(productName)
        stackView.addArrangedSubview(productDescription)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(verticalStackView)
        return stackView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(stackView, bottomView)
        setupSubViews(stackView, bottomView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Confirure cell
        func configure(with data: Any) {
            guard let productData = data as? Product else { return }
            productName.text = productData.name
            productDescription.text = productData.category
            priceLabel.text = String(describing: productData.price)
            fetchImage(from: productData.image)
        }
    
    //MARK: - Private Methods
    private func fetchImage(from url: String?) {
        guard let corectUrl = url else { return }
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.loadImage(from: corectUrl) else {return}
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: imageData)
            }
        }
    }
    
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        productImage.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.3).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.3).isActive = true
        
        verticalStackView.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.6).isActive = true
        verticalStackView.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.3).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
    }
}
