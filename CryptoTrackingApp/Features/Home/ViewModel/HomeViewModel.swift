//
//  HomeViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: AnyObject {
    func didInitial()
    func didSelectedCoin(coin: Coin)
}

final class HomeViewModel: NSObject {
    
    weak var delegate: HomeViewModelProtocol?
    var result: HomeResultType?
}
// MARK: - Helpers
extension HomeViewModel {
    func callApi(requestType: RequestType) {
        let request: Request?
        switch requestType {
        case .coin:
           request = Request(endpoint: .coins(page: 1))
            execute([Coin].self, request: request)
        case .trending:
            request = Request(endpoint: .trending)
            execute(TrendingResult.self, request: request)
        case .exchange:
            request = Request(endpoint: .exchange)
            execute([Exchange].self, request: request)
        }
    }
    private func execute<T: Codable>(_ type: T.Type,request: Request?) {
        guard let request = request else { return }
        RequestService.shared.execute(request: request, type: T.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.processResult(model: model)
                self?.delegate?.didInitial()
            case .failure(let error):
               break
            }
        }
    }
    private func processResult(model: Codable) {
        if let coinResult = model as? [Coin] {
            result = .coins(coinResult)
        } else if let trendingResult = model as? TrendingResult {
            result = .trendings(trendingResult)
        } else if let exchangeResult = model as? [Exchange] {
            result = .exchange(exchangeResult)
        }
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension HomeViewModel: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch result {
        case .coins(let coins):
           return coins.count
        case .trendings(let trendings):
            return trendings.coins.count
        case .exchange( let exchanges):
            return exchanges.count
        case .none:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch result {
        case .coins(let coins):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCoinAndTrendingCollectionViewCell.identitfier, for: indexPath) as! HomeCoinAndTrendingCollectionViewCell
            cell.configure(model: coins[indexPath.item])
            return cell
        case .trendings(let trendings):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCoinAndTrendingCollectionViewCell.identitfier, for: indexPath) as! HomeCoinAndTrendingCollectionViewCell
            cell.configure(model: trendings.coins[indexPath.item].item)
            return cell
        case .exchange(let exchanges):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeExchangeCollectionViewCell.identitifier, for: indexPath) as! HomeExchangeCollectionViewCell
            cell.configure(model: exchanges[indexPath.item])
            return cell
        case .none:
            break
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch result {
        case .coins(let coins):
            delegate?.didSelectedCoin(coin: coins[indexPath.item])
            break
        case .trendings(let trendings):
            break
        case .exchange(let exchanges):
            break
        case .none:
            break
        }
    }
}
