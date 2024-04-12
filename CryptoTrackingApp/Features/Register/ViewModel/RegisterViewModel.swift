//
//  RegisterViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

final class RegisterViewModel {
    
    
}
// MARK: - Helpers
extension RegisterViewModel {
    private func setup() {
        
    }
    func validateEmail(text: String) -> Bool {
        if text.isEmpty && !text.contains("@") {
            return false
        }
        return true
    }
    func validatePassword(text: String) -> Bool {
        if text.isEmpty && text.count < 6 {
            return false
        }
        return true
    }
    private func addProfileImage(data: Data,username: String,completion: @escaping (String?) -> Void) {
        let filePath = username+UUID().uuidString
        let imageRef = Storage.storage().reference().child(filePath)
        imageRef.putData(data,metadata: nil) {_,error in
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(error.localizedDescription)
                    return
                } else if let downloadUrl = url {
                    completion(downloadUrl.absoluteString)
                }
            }
        }
    }
    func registerAndCreateUser(request: RegisterRequest,completion: @escaping (Bool)-> ()) {
        addProfileImage(data: request.imageData, username: request.username) { data in
            if let url = data {
                Auth.auth().createUser(withEmail: request.email, password: request.password) { data,error in
                    if let error = error {
                        completion(false)
                        return
                    }
                    if let data = data {
                        let params = request.createFirebaseModel(id: data.user.uid, imageURL: url)
                        Firestore.firestore().collection("User").document(data.user.uid).setData(params) { error in
                            if let error = error {
                                completion(false)
                                return
                            }
                            completion(true)
                        }
                    }
                    completion(false)
                }
            }
            completion(false)
        }

    }
}
