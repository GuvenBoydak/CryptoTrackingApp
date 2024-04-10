//
//  HomeDetailViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit
import SnapKit

final class HomeDetailViewController: UIViewController {
    private let coin: Coin
    private let homeDetailView: HomeDetailView
    
    init(coin: Coin) {
        self.coin = coin
        homeDetailView = HomeDetailView(frame: .zero,coin: coin)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Helpers
extension HomeDetailViewController {
    private func setup() {
        view.backgroundColor = .systemBackground
        title = coin.name.uppercased()
        addConstraint()
    }
    private func addConstraint() {
        view.addSubview(homeDetailView)
        homeDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }
    }
}
