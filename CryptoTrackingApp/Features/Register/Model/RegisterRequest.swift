//
//  RegisterRequest.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import Foundation

struct RegisterRequest {

    let username,email,password : String
    let imageData: Data
    
    func createFirebaseModel(id: String,imageURL: String) -> [String: Any] {
        return ["id":id,
                "username": username,
                "email": email,
                "imageURL": imageURL]
    }
}
