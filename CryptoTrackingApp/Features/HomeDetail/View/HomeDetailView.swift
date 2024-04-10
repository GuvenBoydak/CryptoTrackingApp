//
//  HomeDetailView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit
import SnapKit

final class HomeDetailView: UIView {
    // MARK: - UIElements
    private let homeDetailElemementsView = HomeDetailElementsView()
    
    // MARK: - Properties
    private let coin: Coin
    
    // MARK: - Life Cycle
     init(frame: CGRect,coin: Coin) {
         self.coin = coin
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Helpers
extension HomeDetailView {
    private func setup() {
        addConstraint()
        configure()
    }
    private func addConstraint() {
        addSubview(homeDetailElemementsView)
        homeDetailElemementsView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    private func configure() {
        homeDetailElemementsView.configure(model: coin)
    }
}
