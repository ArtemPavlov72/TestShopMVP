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
    private let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let productDescription: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemRed
        return label
    }()
    
    private let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.systemGray4.cgColor
        return image
    }()
    
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
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(verticalStackView)
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView1 = UIStackView()
        stackView1.axis = NSLayoutConstraint.Axis.vertical
        stackView1.alignment = .fill
        stackView1.spacing = 20
        stackView1.addArrangedSubview(horizontalStackView)
        stackView1.addArrangedSubview(bottomView)
        return stackView1
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements(mainStackView)
        setupSubViews(mainStackView)
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
            priceLabel.text = String(describing: productData.price) + " $"
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
        productImage.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.4).isActive = true
        
        verticalStackView.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.6).isActive = true
        verticalStackView.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.30).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor).isActive = true
        
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        bottomView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
