//
//  PortfolioViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol PortfolioViewModelProtocol: AnyObject {
    func didReloadData()
    func goToEditAssetVC(asset: Asset)
}

final class PortfolioViewModel: NSObject {
    var assets: [Asset] = []
    private var coins: [Coin] = []
    weak var delegate: PortfolioViewModelProtocol?
    var isShowActivityCell = false
    private var assetActivitys: [Asset] = []
    
    override init() {
        super.init()
    }
}
// MARK: - Helpers
extension PortfolioViewModel {
    private func setup() {
        
    }
    func fetchAssetData() {
        assets.removeAll()
        guard let user = Auth.auth().currentUser else { return }
        Firestore.firestore().collection("Asset").whereField("userId", isEqualTo: user.uid).getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else {
                return
            }
            // Asset verilerini al
            let assets = documents.compactMap { document -> Asset? in
                let assetData = document.data()
                let asset = Asset(data: assetData,documentId: document.documentID)
                return asset
            }
            // Coin verilerini al
            self?.fetchCoins { coins in
                self?.coins = coins
                // Asset ve Coin verilerini eşleştir
                self?.assets = assets.compactMap { asset -> Asset? in
                    if let coin = coins.first(where: { $0.id == asset.id && !asset.isDeleted }) {
                        return Asset(documentId: asset.documentId,
                                     id: asset.id,
                                     userId: asset.userId,
                                     imageUrl: asset.imageUrl,
                                     name: asset.name,
                                     symbol: asset.symbol,
                                     currentPrice: coin.currentPrice,
                                     priceChange: coin.priceChangePercentage24H,
                                     totalPrice: asset.totalPrice,
                                     piece: asset.piece,
                                     date: asset.date,
                                     isDeleted: asset.isDeleted)
                    }
                    return nil
                }.sorted { $0.totalPrice > $1.totalPrice }
                self?.delegate?.didReloadData()
            }
        }
    }
    private func fetchCoins(completion: @escaping ([Coin]) -> ()) {
        let request = Request(endpoint: .searchCoin)
        RequestService.shared.execute(request: request, type: [Coin].self) { result in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    private func deleteAsset(asset: Asset) {
        let params = asset.createFirebaseModel(isDeleted: true)
        Firestore.firestore().collection("Asset").document(asset.documentId).setData(params)
    }
    private func setCoinPrice(coin: Coin){
        UserDefaults.standard.set(coin.currentPrice, forKey: coin.id)
    }
    func fetchAssetActivity(completion: @escaping (Bool) -> ()) {
        assetActivitys.removeAll()
        guard let user = Auth.auth().currentUser else { return }
        Firestore.firestore().collection("Asset").whereField("userId", isEqualTo: user.uid).getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else {
                completion(false)
                return
            }
            documents.forEach { document in
                let asset = Asset(data: document.data(), documentId: document.documentID)
                self?.assetActivitys.append(asset)
            }
            self?.assetActivitys.sorted(by: { $0.date > $1.date })
            completion(true)
        }
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension PortfolioViewModel: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowActivityCell {
            return assetActivitys.count
        }
        return assets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowActivityCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioActivityTableViewCell.identifier, for: indexPath) as! PortfolioActivityTableViewCell
            cell.configure(model: assetActivitys[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableViewCell.identifier, for: indexPath) as! PortfolioTableViewCell
        cell.configure(model: assets[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !isShowActivityCell {
            let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { [weak self] action, view, completion in
                guard let strongSelf = self else { return }
                strongSelf.deleteAsset(asset: strongSelf.assets[indexPath.item])
                strongSelf.fetchAssetData()
                completion(true)
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
            return swipeActions
        }
        return UISwipeActionsConfiguration(actions: [])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !isShowActivityCell {
            let editAction = UIContextualAction(style: .destructive, title: "Edit") { [weak self] action, view, completion in
                guard let strongSelf = self else { return }
                let asset = strongSelf.assets[indexPath.item]
                if let coin = strongSelf.coins.first(where: { $0.id == asset.id }) {
                    strongSelf.setCoinPrice(coin: coin)
                }
                strongSelf.delegate?.goToEditAssetVC(asset: asset)
                completion(true)
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [editAction])
            return swipeActions
        }
        return UISwipeActionsConfiguration(actions: [])
    }
}
