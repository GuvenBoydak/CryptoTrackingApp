//
//  CoinDetail.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import Foundation


struct CoinDetail: Codable {
    let id: ID
    let symbol, name: String
    let description: Tion
    let links: Links
    let image: Image
    let marketCapRank: Int
    let marketData: MarketDatas
  //  var sparklineIn7D: SparklineIn7D?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case description, links, image
        case marketCapRank = "market_cap_rank"
        case marketData = "market_data"
        //case sparklineIn7D = "sparkline_in_7d"
    }
  /*  mutating func setSparklineIn7D(sparklineIn7D: SparklineIn7D) {
        self.sparklineIn7D = sparklineIn7D
    }*/
}
// MARK: - Tion
struct Tion: Codable {
    let en: String
}
// MARK: - Image
struct Image: Codable {
    let thumb, small, large: String
}
// MARK: - Links
struct Links: Codable {
    let homepage: [String]
    let whitepaper: String
    let officialForumURL: [String]
    let twitterScreenName: ID
    let subredditURL: String
    let reposURL: ReposURL

    enum CodingKeys: String, CodingKey {
        case homepage, whitepaper
        case officialForumURL = "official_forum_url"
        case twitterScreenName = "twitter_screen_name"
        case subredditURL = "subreddit_url"
        case reposURL = "repos_url"
    }
}
enum ID: String, Codable {
    case bitcoin = "bitcoin"
    case ethereum = "ethereum"
    case solana = "solana"
    case wrappedBitcoin = "wrapped-bitcoin"
}
// MARK: - ReposURL
struct ReposURL: Codable {
    let github: [String]
}

// MARK: - MarketData
struct MarketDatas: Codable {
    let currentPrice: [String: Double]
    let ath, athChangePercentage: [String: Double]
    let marketCap: [String: Double]
    let marketCapRank: Int
    let totalVolume, high24H, low24H: [String: Double]
    let priceChange24H, priceChangePercentage24H, priceChangePercentage7D, priceChangePercentage14D: Double
    let priceChangePercentage30D, priceChangePercentage60D, priceChangePercentage200D, priceChangePercentage1Y: Double
    let priceChange24HInCurrency, priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: [String: Double]
    let priceChangePercentage14DInCurrency, priceChangePercentage30DInCurrency, priceChangePercentage60DInCurrency, priceChangePercentage200DInCurrency: [String: Double]
    let priceChangePercentage1YInCurrency: [String: Double]
    let totalSupply, maxSupply, circulatingSupply: Int

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case priceChangePercentage7D = "price_change_percentage_7d"
        case priceChangePercentage14D = "price_change_percentage_14d"
        case priceChangePercentage30D = "price_change_percentage_30d"
        case priceChangePercentage60D = "price_change_percentage_60d"
        case priceChangePercentage200D = "price_change_percentage_200d"
        case priceChangePercentage1Y = "price_change_percentage_1y"
        case priceChange24HInCurrency = "price_change_24h_in_currency"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
        case priceChangePercentage14DInCurrency = "price_change_percentage_14d_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        case priceChangePercentage60DInCurrency = "price_change_percentage_60d_in_currency"
        case priceChangePercentage200DInCurrency = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1YInCurrency = "price_change_percentage_1y_in_currency"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
    }
}

// MARK: - Platforms
struct Platforms: Codable {
    let empty: String

    enum CodingKeys: String, CodingKey {
        case empty = ""
    }
}
