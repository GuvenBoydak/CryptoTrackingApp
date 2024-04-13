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
    enum search: String {
        case addPortfolio = "Add Portfolio"
        case search = "Search"
        
        var title: String {
            switch self {
            case .addPortfolio,.search:
                rawValue.localized()
            }
        }
    }
    enum addAsset: String {
        case usd = "USD"
        case totalPrice = "Total Price"
        case addAsset = "Add Asset"
        
        var title: String {
            switch self {
            case .usd,.totalPrice,.addAsset:
                rawValue.localized()
            }
        }
    }
    enum register: String {
        case create = "Create Account"
        case username = "Username"
        case email = "Email"
        case password = "Password"
        case register = "Register"
        
        var title: String {
            switch self {
            case .create,.username,.email,.password,.register:
                rawValue.localized()
            }
        }
    }
    
    enum login: String {
        case login = "Login"
        case clickRegister = "Click To Register"
        
        var title: String {
            switch self {
            case .login,.clickRegister:
                rawValue.localized()
            }
        }
    }
    enum Setting: String {
        case username = "Username"
        case email = "Email"
        case edit = "Edit Profile"
        case dark = "Dark Mode"
        case coinGecko = "CoinGecko Api"
        case github = "Github"
        case signOut = "Sign Out"
        
        var title: String {
            switch self {
            case .username,.email,.edit,.dark,.coinGecko,.github,.signOut:
                rawValue.localized()
            }
        }
    }
}
