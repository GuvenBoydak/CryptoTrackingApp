//
//  HomeCoinAndTrendingCollectionViewCellViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation


enum HomeCoinAndTrendingCollectionViewCellViewModel {
    case coins(coin: Coin)
    case trendings(trending: Coin)
}
