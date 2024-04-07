//
//  RequestService.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 7.04.2024.
//

import Foundation

final class RequestService {
    static let shared = RequestService()
    
    private init(){ }
    
    func execute<T: Codable>(request: Request,type: T.Type,completion: @escaping (Result<T,Error>) -> ()) {
        guard let url = request.getURL() else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data,
                  error == nil else {
                completion(.failure(CustomError.noData))
                return
            }
            do {
                let value = try JSONDecoder().decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(CustomError.decodingError))
            }
        }.resume()
    }
}
