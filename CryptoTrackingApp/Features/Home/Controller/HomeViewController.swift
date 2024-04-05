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

    }
}
//MARK: Helpers
extension HomeViewController {
    private func setup() {
        view.backgroundColor = .systemBackground
        title = LocalizableKey.Tabbar.home.title
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
