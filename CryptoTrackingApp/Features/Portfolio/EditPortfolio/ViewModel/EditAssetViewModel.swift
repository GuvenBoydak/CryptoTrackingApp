//
//  EditAssetViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 16.04.2024.
//

import Foundation
import FirebaseFirestore

final class EditAssetViewModel {
    
    func updateAsset(asset: Asset) {
        let params = asset.createFirebaseModel(isDeleted: false)
        Firestore.firestore().collection("Asset").document(asset.documentId).setData(params)
    }
}
