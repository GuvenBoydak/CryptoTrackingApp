//
//  HomeView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import UIKit
import SnapKit


final class HomeView: UIView {
    // MARK: - UIElements
    private let homeHeaderView = HomeHeaderView()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(HomeCoinAndTrendingCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    private  let coinsButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Coin's",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemBlue]), for: .normal)
        button.addTarget(self, action: #selector(didTapCoinsButton), for: .touchUpInside)
        return button
    }()
    private let coinsBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    private  let trendingButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Trending",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemGray]), for: .normal)
        button.addTarget(self, action: #selector(didTapTrendingButton), for: .touchUpInside)
        return button
    }()
    private let trendingBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private  let exchangeButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Exchange",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemGray]), for: .normal)
        button.addTarget(self, action: #selector(didTapExchangeButton), for: .touchUpInside)
        return button
    }()
    private let exchangeBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private let marketRankLabel: UILabel = {
       let label = UILabel()
        label.text = "#"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let volumeLabel: UILabel = {
       let label = UILabel()
        label.text = "24s %"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "Fiyat"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    var stackView: UIStackView!
    // MARK: - Properties
    let homeVM = HomeViewModel()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        homeVM.delegate = self
        setup()
        homeVM.callApi(requestType: .coin)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension HomeView {
    private func setup() {
        setupHeaderView()
        setupAddConstraint()
        setupSpinerCollectionView()
    }
    private func setupHeaderView() {
        addSubview(homeHeaderView)
        homeHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    private func setupSpinerCollectionView() {
        collectionView.delegate = homeVM
        collectionView.dataSource = homeVM
        collectionView.isHidden = false
        collectionView.alpha  = 1
        spinner.startAnimating()
        
        addSubViews(spinner,collectionView)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(snp.leading).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
        }
    }
    private func setupAddConstraint() {
        let coinStackView = UIStackView(arrangedSubviews: [coinsButton,coinsBarView])
        coinStackView.axis = .vertical
        let trendingStackView = UIStackView(arrangedSubviews: [trendingButton,trendingBarView])
        trendingStackView.axis = .vertical
        let exchangeStakView = UIStackView(arrangedSubviews: [exchangeButton,exchangeBarView])
        exchangeStakView.axis = .vertical
        
        stackView = UIStackView(arrangedSubviews: [coinStackView,trendingStackView,exchangeStakView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        addSubViews(stackView,
                    marketRankLabel,
                    nameLabel,
                    volumeLabel,
                    priceLabel)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(homeHeaderView.marketCapView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        coinsBarView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        trendingBarView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        exchangeBarView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        marketRankLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalTo(marketRankLabel.snp.trailing).offset(35)
        }
        volumeLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel.snp.trailing).offset(80)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
    private func setTitleColor(button: UIButton,color: UIColor) {
        if button == coinsButton {
            button.setAttributedTitle(NSAttributedString(string: "Coin's",
                                                              attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                           .foregroundColor: color]), for: .normal)
            coinsBarView.backgroundColor = color
        } else if button == trendingButton {
            button.setAttributedTitle(NSAttributedString(string: "Trending",
                                                                 attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                              .foregroundColor: color]), for: .normal)
            trendingBarView.backgroundColor = color
        } else if button == exchangeButton {
            button.setAttributedTitle(NSAttributedString(string: "Exchange",
                                                                 attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                              .foregroundColor: color]), for: .normal)
            exchangeBarView.backgroundColor = color
        }
    }
}
// MARK: - Selectors
extension HomeView {
    @objc private func didTapCoinsButton(_ sender: UIButton) {
        setTitleColor(button: sender, color: .systemBlue)
        trendingButton.setAttributedTitle(NSAttributedString(string: "Trending",
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        trendingBarView.backgroundColor = .lightGray
        exchangeButton.setAttributedTitle(NSAttributedString(string: "Exchange",
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        exchangeBarView.backgroundColor = .lightGray
        homeVM.callApi(requestType: .coin)
    }
    @objc private func didTapTrendingButton(_ sender: UIButton) {
        setTitleColor(button: sender, color: .systemBlue)
        coinsButton.setAttributedTitle(NSAttributedString(string: "Coin's",
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        coinsBarView.backgroundColor = .lightGray
        exchangeButton.setAttributedTitle(NSAttributedString(string: "Exchange",
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        exchangeBarView.backgroundColor = .lightGray
        homeVM.callApi(requestType: .trending)
    }
    @objc private func didTapExchangeButton(_ sender: UIButton) {
        setTitleColor(button: sender, color: .systemBlue)
        coinsButton.setAttributedTitle(NSAttributedString(string: "Coin's",
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        coinsBarView.backgroundColor = .lightGray
        trendingButton.setAttributedTitle(NSAttributedString(string: "Trending",
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        trendingBarView.backgroundColor = .lightGray
    }
}
// MARK: - HomeViewModelProtocol
extension HomeView: HomeViewModelProtocol {
    func didInitial() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
