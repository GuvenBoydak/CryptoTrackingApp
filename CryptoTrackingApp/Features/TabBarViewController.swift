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
            [createNavigation(rootController: homeVC,
                              title: LocalizableKey.Tabbar.home.title,
                              image: ImageKey.Tabbar.home.rawValue,
                              tag: 1),
             createNavigation(rootController: portfolioVC,
                              title: LocalizableKey.Tabbar.myPortfolio.title,
                              image: ImageKey.Tabbar.portfolio.rawValue,
                              tag: 2),
             createNavigation(rootController: settingVC,
                              title: LocalizableKey.Tabbar.setting.title,
                              image: ImageKey.Tabbar.setting.rawValue,
                              tag: 3)],
            animated: true)
    }
    private func createNavigation(rootController: UIViewController,title: String,image: String,tag: Int) -> UINavigationController {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        let navController = UINavigationController(rootViewController: rootController)
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.tabBarItem = UITabBarItem(title: title,
                                                image: UIImage(systemName: image),
                                                tag: tag)
        return navController
    }
}
