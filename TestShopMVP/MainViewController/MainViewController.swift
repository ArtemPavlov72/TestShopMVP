//
//  ViewController.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 04.04.2023.
//

import UIKit

protocol MainViewControllerInputProtocol: AnyObject {
    
}

protocol MainViewControllerOutputProtocol: AnyObject {
    init(view: MainViewControllerInputProtocol)
}

protocol MainViewControllerDelegate {
    func didSelectCategory(_ name: String)
}

class MainViewController: UIViewController {

    //MARK: - Private Properties
    private var banners: [Banner] = []
    private var products: [Product] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var collectionView: UICollectionView!
    
    //
    var presenter: MainViewControllerOutputProtocol!
    private let configurator: MainViewControllerConfiguratorInputProtocol = MainViewConfigurator()
    //
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        configurator.configure(with: self)
        
        //
        setupNavigationBar()
        setupCollectionView()
        getProducts {
            self.createData()
            self.createDataSource()
        }
    }
    
    //MARK: - Private Methods
    func getProducts(completion: @escaping () -> Void) {
        DataManager.shared.createTestProducts(completion: { products in
            self.products = products
            completion()
        })
    }
    
    private func createData() {
        banners = DataManager.shared.createBanners()
        products.sort(by: { $0.category < $1.category })
    }
    
    private func setupNavigationBar() {
        createCustomLeftButtonItem()
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func createCustomLeftButtonItem() {
        let button = UIButton(type: .system)
        button.setTitle("Москва", for: .normal)
        button.tintColor = UIColor.black
        button.setImage(UIImage(named: "drop"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseId)
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
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as? HeaderView else { return HeaderView() }
            sectionHeader.categories = Array(NSOrderedSet(array: self.products.compactMap {
                $0.category
            } )) as? [String] ?? []
            sectionHeader.delegate = self
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
        
        layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.reuseId)
                
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
        return layoutSection
    }
    
    private func createProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 0, bottom: 16, trailing: 0)
       
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
     
        header.pinToVisibleBounds = true
        layoutSection.boundarySupplementaryItems = [header]
        
        layoutSection.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseId)
        ]
        
        return layoutSection
    }
}

extension MainViewController {
    enum Section: Hashable, CaseIterable {
        case banner
        case productInfo
    }
}

//MARK: - MainViewControllerDelegate
extension MainViewController: MainViewControllerDelegate {
    func didSelectCategory(_ name: String) {
        
        let indexOfFirstElementOfCategory = products.firstIndex(where: { $0.category == name } )
        guard let index = indexOfFirstElementOfCategory else {return}
        
        let indexPath = IndexPath(item: index, section: 1)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
}

extension MainViewController: MainViewControllerInputProtocol {
    
}
