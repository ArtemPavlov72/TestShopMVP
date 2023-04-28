//
//  TabBarViewController.swift
//  TestShopMVP
//
//  Created by Artem Pavlov on 16.04.2023.
//

import UIKit

protocol TabBarViewControllerInputProtocol: AnyObject {
    func setViewControllers(for tabBarItems: [TabBarItem])
}

protocol TabBarViewControllerOutputProtocol: AnyObject {
    init(view: TabBarViewControllerInputProtocol)
    func viewDidLoad()
}

class TabBarViewController: UITabBarController {

    var presenter: TabBarViewControllerOutputProtocol!
    private let configurator: TabBarViewControllerConfiguratorInputProtocol = TabBarViewControllerConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.viewDidLoad()
        tabBar.tintColor = UIColor.red
    }
    
    //MARK: - Private Methods
    private func createViewController(for item: TabBarItem) -> UIViewController {
        var viewController: UIViewController {
            switch item {
            case .menu:
                return MainViewController()
            case .contacts:
                return ContactsViewController()
            case .profile:
                return UserViewController()
            case .cart:
                return BasketViewController()
            }
        }
        return viewController
    }
    
    private func installViewControllers(for item: TabBarItem) -> UINavigationController {
        let navController = UINavigationController(rootViewController: createViewController(for: item))
        navController.tabBarItem.title = item.rawValue
        navController.tabBarItem.image = UIImage(named: item.rawValue)
        return navController
    }
    
    private func setupTabBar(for items: [TabBarItem]) {
        viewControllers = items.map { installViewControllers(for: $0) }
    }
}

// MARK: - TabBarViewControllerInputProtocol
extension TabBarViewController: TabBarViewControllerInputProtocol {
    func setViewControllers(for tabBarItems: [TabBarItem]) {
        setupTabBar(for: tabBarItems)
    }
}
