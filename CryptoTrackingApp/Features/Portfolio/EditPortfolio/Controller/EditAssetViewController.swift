//
//  EditPortfolioViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 16.04.2024.
//

import UIKit

final class EditAssetViewController: UIViewController {
    private let editView = EditAssetView()
    let asset: Asset
    
    init(asset: Asset) {
        self.asset = asset
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
extension EditAssetViewController {
    private func setup() {
        editView.delegate = self
        view.backgroundColor = .systemBackground
        title = asset.name.uppercased()
        editView.configure(asset: asset)
        view.addSubview(editView)
        editView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
// MARK: - EditPortfolioViewProtocol
extension EditAssetViewController: EditAssetViewProtocol {
    func popToRootControlller() {
        navigationController?.popViewController(animated: true)
    }
}
