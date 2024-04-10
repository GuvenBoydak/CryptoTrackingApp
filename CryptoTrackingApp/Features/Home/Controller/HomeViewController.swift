//
//  HomeViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 4.04.2024.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        homeView.delegate = self
    }
}
//MARK: Helpers
extension HomeViewController {
    private func setup() {
        view.backgroundColor = .systemBackground
        title = LocalizableKey.Tabbar.home.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ImageKey.Home.person.rawValue), style: .done, target: self, action: #selector(didTapProfile))
        setupHomeView()
    }
    private func setupHomeView() {
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
// MARK: - Selector
extension HomeViewController {
    @objc
    private func didTapProfile() {
        
    }
}
// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func didSelectedCoin(coin: Coin) {
        let detailVC = HomeDetailViewController(coin: coin)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
