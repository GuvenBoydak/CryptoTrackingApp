//
//  LoginViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import FirebaseAuth

final class LoginViewModel {
    
}
// MARK: - Helpers
extension LoginViewModel {
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
    func loginProcess(email: String,Password: String,completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: Password) { data, error in
            if let error = error {
                completion(false)
                return
            }
            if let data = data {
                completion(true)
            }
            completion(false)
        }
    }
}
