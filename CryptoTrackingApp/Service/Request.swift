//
//  Request.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation


struct Request {
    let baseURL = "https://api.coingecko.com/api/v3/"
    let endpoint: Endpoint
    let apiKey = "x_cg_api_key=CG-PnfrX8FAguqMCVtZY3K77srk"
    
    func getURL() -> URL? {
        let urlString = baseURL + endpoint.urlString() + apiKey
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
}

enum Endpoint {
    case coins(page: Int)
    case searchCoin
    case coinById(id: String)
    case trending
    case exchange
    case global

    func urlString() -> String {
        switch self {
        case .coins(let page):
            return "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=\(page)&sparkline=true&price_change_percentage=24h?"
        case .searchCoin:
            return "coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=24h?"
        case .coinById(let id):
            return "coins/\(id)?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=true?"
        case .trending:
            return "search/trending?"
        case .exchange:
            return "exchanges?"
        case .global:
            return "global?"
        }
    }
}

enum CustomError: Error {
    case invalidURL
    case requestFailed
    case noData
    case decodingError
}
