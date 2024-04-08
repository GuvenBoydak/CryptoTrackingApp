//
//  Exchange.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 8.04.2024.
//

import Foundation

struct Exchange: Codable {
    let id, name: String
    let url: String
    let image: String
    let trustScore, trustScoreRank: Int
    let tradeVolume24HBtc: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case url, image
        case trustScore = "trust_score"
        case trustScoreRank = "trust_score_rank"
        case tradeVolume24HBtc = "trade_volume_24h_btc"
    }
}
