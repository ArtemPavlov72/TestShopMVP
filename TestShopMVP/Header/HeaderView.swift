//
//  Header.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 05.04.2023.
//

import UIKit

class Header: UICollectionReusableView {
    
    static let reuseId: String = "headerSectionId"
    
    var viewModel: HeaderCellViewModelProtocol?
    
    var categories: [String] = []
    private var selectedCategory: Int = 0
    var delegate: MainViewControllerDelegate?
    
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Stop trying to make storyboards happen.")
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderViewCell.self, forCellWithReuseIdentifier: HeaderViewCell.reuseId)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return self.createSection()
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config
        
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return layoutSection
    }
}

// MARK: - UICollectionViewDataSource
extension Header: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.reuseId, for: indexPath) as! HeaderViewCell
        
        viewModel = HeaderCellViewModel(category: categories[indexPath.item])
        
        cell.viewModel = viewModel
        
        if selectedCategory == indexPath.item {
            cell.configureSelectedAppearance()
        } else {
            cell.configureStandartAppearance()
        }
        return cell
    }
}

extension Header: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      delegate?.didSelectCategory(categories[indexPath.item])
      selectedCategory = indexPath.item
      collectionView.reloadData()
     }
}
