//
//  SearchViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    private let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}
// MARK: - Helpers
extension SearchViewController {
    private func setup() {
        searchView.delegate = self
        view.backgroundColor = .systemBackground
        addConstraint()
    }
    private func addConstraint() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
// MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func didSelectedCoin(coin: Coin) {
        let addAssetVC = AddAssetViewController(coin: coin)
        addAssetVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(addAssetVC, animated: true)
    }
}
