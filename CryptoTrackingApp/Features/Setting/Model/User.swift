//
//  User.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 13.04.2024.
//

import Foundation

struct User {
    init(id: String, username: String, email: String, imageUrl: String) {
        self.id = id
        self.username = username
        self.email = email
        self.imageUrl = imageUrl
    }
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.imageUrl = data["imageURL"] as? String ?? ""
    }
    let id,username,email,imageUrl: String
}
