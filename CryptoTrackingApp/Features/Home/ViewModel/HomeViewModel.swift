//
//  HomeViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func didİnitialCoins()
}

final class HomeViewModel: NSObject {
    weak var delegate: HomeViewModelProtocol?
    var coins: [Coin] = []
    var isLoading = true
}
// MARK: - Helpers
extension HomeViewModel {
    func fetchCoins() {
        let request = Request(endpoint: .coins(page: 1))
        RequestService.shared.execute(request: request, type: [Coin].self) { [weak self] result in
            switch result {
            case .success(let data):
                    self?.isLoading = false
                    self?.coins = data
                    self?.delegate?.didİnitialCoins()
            case .failure(_):
                self?.isLoading = true
            }
        }
    }
    func fetchImage(imageURL: String,completion: @escaping (Result<Data,Error>) -> ()) {
        guard let imageURL = URL(string: imageURL) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageURL, completion: completion)
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension HomeViewModel: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coins.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCoinAndTrendingCollectionViewCell
        cell.configure(viewModel: .coins(coin: coins[indexPath.item]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
