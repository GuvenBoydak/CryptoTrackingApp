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
}
