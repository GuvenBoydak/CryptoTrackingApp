//
//  Market.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import Foundation

struct Market: Codable {
    let data: MarketData
}

// MARK: - DataClass
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
    }
}
