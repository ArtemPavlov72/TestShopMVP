//
//  TabBarViewController.swift
//  TestShopMVP
//
//  Created by Артем Павлов on 16.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        tabBar.tintColor = UIColor.red
    }
    
    //MARK: - Private Methods
    private func setupTabBar() {
        let mainVC = MainViewController()
        let contactsVC = ContactsViewController()
        let userVC = UserViewController()
        let basketVC = BasketViewController()
        
        mainVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "menu"), tag: 1)
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(named: "contacts"), tag: 2)
        userVC.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "profile"), tag: 3)
        basketVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cart"), tag: 4)
        viewControllers = [mainVC, contactsVC, userVC, basketVC]
    }
}
