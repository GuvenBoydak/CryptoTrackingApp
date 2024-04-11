//
//  SearchView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import UIKit
import SnapKit

protocol SearchViewProtocol: AnyObject {
    func didSelectedCoin(coin: Coin)
}

final class SearchView: UIView {
    // MARK: - UIElements
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identitifier)
        return tableview
    }()
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = LocalizableKey.search.search.title
        return bar
    }()
    private let addPortfolioTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.search.addPortfolio.title
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    // MARK: - Properties
    private let searchVM = SearchViewModel()
    weak var delegate: SearchViewProtocol?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension SearchView {
    private func setup() {
        searchVM.delegate = self
        searchBar.delegate = self
        addConstraint()
    }
    private func addConstraint() {
        tableview.delegate = searchVM
        tableview.dataSource = searchVM
        addSubViews(searchBar,addPortfolioTitleLabel,tableview)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().offset(-2)
            make.height.equalTo(40)
        }
        addPortfolioTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
        }
        tableview.snp.makeConstraints { make in
            make.top.equalTo(addPortfolioTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}
//MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchVM.searchByCoins(searchText.lowercased())
    }
}
//MARK: - UISearchBarDelegate
extension SearchView: SearchViewModelProtocol {
    func didSelectedCoin(coin: Coin) {
        delegate?.didSelectedCoin(coin: coin)
    }
    func didReloadData() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}
