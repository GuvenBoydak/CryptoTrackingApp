//
//  SearchViewModel.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import UIKit

protocol SearchViewModelProtocol: AnyObject {
    func didReloadData()
}

final class SearchViewModel: NSObject {
    var coins: [Coin] = []
    var searchedCoins: [Coin] = []
    weak var delegate: SearchViewModelProtocol?
    
    override init() {
        super.init()
        setup()
        fetchCoins()
    }
}
// MARK: - Helpers
extension SearchViewModel {
    private func setup() {
        
    }
    private func fetchCoins() {
        let request = Request(endpoint: .searchCoin)
        RequestService.shared.execute(request: request, type: [Coin].self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.coins = model
            case .failure:
               break
            }
        }
    }
    func searchByCoins(_ value: String) {
        searchedCoins = coins.filter { coin in
            coin.id.contains(value)
        }
        delegate?.didReloadData()
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension SearchViewModel: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedCoins.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identitifier, for: indexPath) as! SearchTableViewCell
        cell.configure(model: searchedCoins[indexPath.row])
        return cell
    }
}

