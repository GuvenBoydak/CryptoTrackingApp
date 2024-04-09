//
//  HomeHeaderViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import Foundation

final class HomeHeaderViewModel {
    func fetchMarketData(completion: @escaping (MarketData?) -> ()) {
        let request = Request(endpoint: .global)
        RequestService.shared.execute(request: request, type: Market.self) { result in
            switch result {
            case .success(let model):
                completion(model.data)
            case .failure:
                break
            }
        }
    }
}
