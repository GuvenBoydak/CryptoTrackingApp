//
//  PortfolioViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 4.04.2024.
//

import UIKit


final class PortfolioViewController: UIViewController {

    private let portfolioView = PortfolioView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        portfolioView.portfolioVM.fetchAssetData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        portfolioView.didReloadTableView()
    }
}
// MARK: - Helpers
extension PortfolioViewController {
    private func setup() {
        portfolioView.delegate = self
        view.backgroundColor = .systemBackground
        title = LocalizableKey.Portfolio.myPortfolio.title
        addConstraint()
    }
    private func addConstraint() {
        view.addSubview(portfolioView)
        portfolioView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(8)
        }
    }
}
// MARK: - PortfolioViewProtocol
extension PortfolioViewController: PortfolioViewProtocol {    
    func didTapAddAsset() {
        let searchVC = SearchViewController()
        searchVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(searchVC, animated: true)
    }
}
