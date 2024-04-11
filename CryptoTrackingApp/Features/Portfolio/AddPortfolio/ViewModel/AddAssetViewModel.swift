//
//  AddAssetViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 11.04.2024.
//

import Foundation
import FirebaseFirestore

final class AddAssetViewModel {
    
}
// MARK: - Helpers
extension AddAssetViewModel {
    func createAsset(asset: Asset) {
        let model = asset.createFirebaseModel()
        Firestore.firestore().collection("Asset").addDocument(data: model) { error in
            guard let error = error else {
                return
            }
        }
    }
}
