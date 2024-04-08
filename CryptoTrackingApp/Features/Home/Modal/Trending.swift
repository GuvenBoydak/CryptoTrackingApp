//
//  Trending.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation
struct TrendingResult: Codable {
    let coins: [Trending]
}

struct Trending: Codable {
    let item: TrendingCoin
}

// MARK: - Item
struct TrendingCoin: Codable {
    let id: String
    let coinID: Int
    let name, symbol: String
    let marketCapRank: Int
    let small: String
    let data: ItemData

    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol
        case marketCapRank = "market_cap_rank"
        case small
        case  data
    }
}

// MARK: - ItemData
struct ItemData: Codable {
    let price: Double
    let priceChangePercentage24H: [String: Double]
    var marketCap,totalVolume: String
    let sparkline: String

    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case sparkline
    }
}
