//
//  SettingViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 13.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class SettingViewModel: ObservableObject {
   @Published var user: User?
    
    init() {
        fetchData()
    }
}
// MARK: - Helpers
extension SettingViewModel {
    func fetchData() {
        if user == nil {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore().collection("User").document(userId).getDocument { snapshot, error in
                if let eeror = error {
                    return
                }
                if let data = snapshot?.data() {
                    self.user = User(data: data)
                }
            }
        }
    }
}
