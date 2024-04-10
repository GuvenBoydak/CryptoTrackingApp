//
//  ImageKey.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import Foundation

struct ImageKey {
    enum Tabbar: String {
        case home = "house.circle"
        case portfolio = "wallet.pass"
        case setting = "gear.circle"
    }
    enum Home: String {
        case person = "person.circle"
    }
    enum Portfolio: String {
        case addAsset = "plus.app"
    }
}
