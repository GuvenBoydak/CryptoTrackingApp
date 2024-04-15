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
}

final class PortfolioViewModel: NSObject {
    var assets: [Asset] = []
    weak var delegate: PortfolioViewModelProtocol?
    var isShowActivityCell = false
    
    override init() {
        super.init()
    }
}
// MARK: - Helpers
extension PortfolioViewModel {
    private func setup() {
        
    }
    func fetchAssetData() {
        guard let user = Auth.auth().currentUser else { return }
        Firestore.firestore().collection("Asset").whereField("userId", isEqualTo: user.uid).getDocuments { [weak self] snapshot, error in
            guard let documents = snapshot?.documents else {
                return
            }
            // Asset verilerini al
            let assets = documents.compactMap { document -> Asset? in
                let assetData = document.data()
                let asset = Asset(data: assetData)
                return asset
            }
            // Coin verilerini al
            self?.fetchCoins { coins in
                // Asset ve Coin verilerini eşleştir
                self?.assets = assets.compactMap { asset -> Asset? in
                    if let coin = coins.first(where: { $0.id == asset.id }) {
                        return Asset(id: asset.id,
                                     userId: asset.userId,
                                     imageUrl: asset.imageUrl,
                                     name: asset.name,
                                     symbol: asset.symbol,
                                     currentPrice: coin.currentPrice,
                                     priceChange: coin.priceChangePercentage24H,
                                     totalPrice: asset.totalPrice,
                                     piece: asset.piece,
                                     date: asset.date)
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
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension PortfolioViewModel: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isShowActivityCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioActivityCollectionViewCell.identifier, for: indexPath) as! PortfolioActivityCollectionViewCell
            cell.configure(model: assets[indexPath.row])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PortfolioCollectionViewCell.identifier, for: indexPath) as! PortfolioCollectionViewCell
        cell.configure(model: assets[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
