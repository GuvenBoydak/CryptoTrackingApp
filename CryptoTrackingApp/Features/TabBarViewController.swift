//
//  TabBarViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 4.04.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
    }
}
//MARK: - Helpers
extension TabBarViewController {
    private func setup() {
        let homeVC = HomeViewController()
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        let portfolioVC = PortfolioViewController()
        portfolioVC.navigationItem.largeTitleDisplayMode = .automatic
        let settingVC = SettingViewController()
        settingVC.navigationItem.largeTitleDisplayMode = .automatic
        
        setViewControllers(
           [createNavigation(rootController: homeVC, title: "Home", image: "house", tag: 1),
           createNavigation(rootController: portfolioVC, title: "My Portfolio", image: "wallet.pass", tag: 2),
            createNavigation(rootController: settingVC, title: "Setting", image: "person", tag: 3)],
           animated: true)
    }
    private func createNavigation(rootController: UIViewController,title: String,image: String,tag: Int) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: image), tag: tag)
        return navController
    }
}
