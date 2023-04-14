//
//  RoundedBackgroundView.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 14.04.2023.
//

import UIKit

class RoundedBackgroundView: UICollectionReusableView {
    
    static let reuseId: String = "backgroundView"
    
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(insetView)
        
        NSLayoutConstraint.activate([
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            trailingAnchor.constraint(equalTo: insetView.trailingAnchor, constant: 0),
            insetView.topAnchor.constraint(equalTo: topAnchor, constant: 50), 
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
