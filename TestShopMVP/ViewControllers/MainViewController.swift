//
//  ViewController.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 04.04.2023.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Private Properties
    private var banners: [Banner] = []
    private var products: [Product] = []
    private var categories: [String] = []
    
    private var cars: [Product] = []
    private var games: [Product] = []
    private var phones: [Product] = []
    private var kids: [Product] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var collectionView: UICollectionView!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchProducts {
            self.getData()
            self.createDataSource()
            
        }
    }
    
    //MARK: - Private Methods
    func fetchProducts(completion: @escaping () -> Void) {
        let urls = Link.allCases
        let group = DispatchGroup()
        
        _ = urls.map { url in
            group.enter()
            
            switch url {
            case .latest:
                NetworkManager.shared.fetchData(dataType: Latest.self, from: url.rawValue) { result in
                    switch result {
                    case.success(let product):
                        product.latest.map { dataProduct in
                            let newProduct = Product(
                                category: dataProduct.category,
                                name: dataProduct.name,
                                price: dataProduct.price,
                                image: dataProduct.image_url
                            )
                            self.products.append(newProduct)
                        }
                        group.leave()
                    case.failure(let error):
                        print(error)
                        group.leave()
                    }
                }
            case .sale:
                NetworkManager.shared.fetchData(dataType: Sale.self, from: url.rawValue) { result in
                    switch result {
                    case.success(let product):
                        product.flash_sale.map { dataProduct in
                            let newProduct = Product(
                                category: dataProduct.category,
                                name: dataProduct.name,
                                price: dataProduct.price,
                                image: dataProduct.image_url
                            )
                            self.products.append(newProduct)
                           
                        }
                        group.leave()
                    case.failure(let error):
                        print(error)
                        group.leave()
                    }
                }
            }
        }
        group.notify(queue: .main) {
            completion()
        }
    }
    
    private func getData() {
        banners = DataManager.shared.createBanners()
        
        categories = Array(NSOrderedSet(array: products.compactMap({ $0.category } ))) as? [String] ?? []
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseId)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
    }
    
    // MARK: - Manage the Data
    private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with data: AnyHashable, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: data)
        return cell
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { [self]
            collectionView, indexPath, data in
            
            let sections = Section.allCases[indexPath.section]
            
            switch sections {
            case .banner:
                return configure(BannerCell.self, with: data, for: indexPath)
            case .productInfo:
                return configure(ProductCell.self, with: data, for: indexPath)
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseId, for: indexPath) as? Header else { return Header() }
//            guard let item = self.dataSource?.itemIdentifier(for: indexPath) else { return Header() }
//            guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: item) else { return Header() }

            sectionHeader.categories = self.categories

            return sectionHeader
        }
        
        dataSource?.apply(generateSnapshot(), animatingDifferences: true)
    }
    
    
    
    private func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable>  {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([Section.banner])
        snapshot.appendItems(banners, toSection: .banner)
        
        snapshot.appendSections([Section.productInfo])
        snapshot.appendItems(products, toSection: .productInfo)

        return snapshot
    }
    
    // MARK: - Setup Layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            
            switch section {
            case .banner:
                return self.createBannerSection()
            case .productInfo:
                return self.createProductSection()
            }
        }
        
  //      layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.reuseId)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config

        return layout
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 0)
       // layoutSection.decorationItems = [
       //     NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseId)
      //  ]
        return layoutSection
    }
    
    private func createProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
       // item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 4, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 4, bottom: 0, trailing: 8)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        //
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
       // let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .bottom)
        header.pinToVisibleBounds = true //
        layoutSection.boundarySupplementaryItems = [header]
//        layoutSection.decorationItems = [
//            NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseId)
//        ]
        
        return layoutSection
    }
}

extension MainViewController {
    enum Section: Hashable, CaseIterable {
        case banner
        case productInfo
    }
}

