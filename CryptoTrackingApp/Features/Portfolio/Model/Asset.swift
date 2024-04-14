//
//  Asset.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 11.04.2024.
//

import Foundation

struct Asset {
    init(id: String,userId: String, imageUrl: String, name: String, symbol: String, currentPrice: Double? = nil, priceChange: Double? = nil, totalPrice: Double, piece: Double, date: Date) {
        self.id = id
        self.userId = userId
        self.imageUrl = imageUrl
        self.name = name
        self.symbol = symbol
        self.currentPrice = currentPrice
        self.priceChange = priceChange
        self.totalPrice = totalPrice
        self.piece = piece
        self.date = date
    }
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.userId = data["userId"] as? String ?? ""
        self.imageUrl = data["imageURL"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.symbol = data["symbol"] as? String ?? ""
        self.currentPrice = nil
        self.priceChange = nil
        self.totalPrice = data["totalPrice"] as? Double ?? 0
        self.piece = data["piece"] as? Double ?? 0
        self.date = data["date"] as? Date ?? Date()
    }
    let id: String
    let userId: String
    let imageUrl: String
    let name: String
    let symbol: String
    var currentPrice: Double?
    var priceChange: Double?
    let totalPrice: Double
    let piece: Double
    let date: Date
    
    func createFirebaseModel() -> [String: Any] {
        return ["id": id,
                "userId": userId,
                "imageURL": imageUrl,
                "name": name,
                "symbol": symbol,
                "totalPrice": totalPrice,
                "piece": piece,
                "date": date]
    }
}
