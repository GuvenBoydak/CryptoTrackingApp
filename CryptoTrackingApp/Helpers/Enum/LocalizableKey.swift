//
//  LocalizableKey.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import Foundation


struct LocalizableKey {
    enum Tabbar: String {
        case home = "Home"
        case myPortfolio = "My Portfolio"
        case setting = "Setting"
        
        var title: String {
            switch self {
            case .home,.myPortfolio,.setting:
                rawValue.localized()
            }
        }
    }
    enum Home: String {
        case coin = "Coin's"
        case trending = "Trending"
        case exchange = "Exchange"
        case name = "Name"
        case price = "Price"
        case volume = "24s BTC Volume"
        
        var title: String {
            switch self {
            case .coin,.trending,.exchange,.name,.price,.volume:
                rawValue.localized()
            }
        }
    }
    enum HomeHeader: String {
        case market = "Market Cap"
        case volume = "24s Volume"
        case dominance = "BTC Dominance"
        
        var title: String {
            switch self {
            case .market,.volume,.dominance:
                rawValue.localized()
            }
        }
    }
    enum Portfolio: String {
        case myPortfolio = "MY Portfolio"
        case total = "Total :"
        case currentAsset = "Current Asset"
        case activity = "Activity"
        case asset = "Asset"
        case price = "Price"
        case piece = "Piece"
        
        var title: String {
            switch self {
            case .myPortfolio,.total,.currentAsset,.activity,.asset,.price,.piece:
                rawValue.localized()
            }
        }
    }
}
