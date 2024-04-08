//
//  HomeResultType.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation


enum HomeResultType {
    case coins([Coin])
    case trendings(TrendingResult)
    case exchange([Exchange])
}
