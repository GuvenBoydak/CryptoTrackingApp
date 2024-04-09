//
//  HomeDetailViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import Foundation

final class HomeDetailViewModel {
    
}
// MARK: - Helpers
extension HomeDetailViewModel {
    func fetchCoinById(id: String,completion: @escaping (Result<CoinDetail,Error>) -> ()) {
        let request = Request(endpoint: .coinById(id: id))
        
        RequestService.shared.execute(request: request, type: CoinDetail.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
