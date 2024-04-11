//
//  AddAssetViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 11.04.2024.
//

import UIKit

final class AddAssetViewController: UIViewController {
    var coin: Coin?
    private let addAssetView = AddAssetView()
    
    init(coin: Coin) {
        self.coin = coin
        addAssetView.coin = coin
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
extension AddAssetViewController {
    private func setup() {
        addAssetView.delegate = self
        view.backgroundColor = .systemBackground
        title = coin?.name.uppercased()
        addConstraint()
        addAssetView.configure()
    }
    private func addConstraint() {
        view.addSubview(addAssetView)
        addAssetView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
// MARK: - AddAssetViewProtocol
extension AddAssetViewController: AddAssetViewProtocol {
    func popToRootControlller() {
       navigationController?.popToRootViewController(animated: true)
    }
}
