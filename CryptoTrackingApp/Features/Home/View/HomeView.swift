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
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(HomeCoinAndTrendingCollectionViewCell.self, forCellWithReuseIdentifier: HomeCoinAndTrendingCollectionViewCell.identitfier)
        collectionView.register(HomeExchangeCollectionViewCell.self, forCellWithReuseIdentifier: HomeExchangeCollectionViewCell.identitifier)
        return collectionView
    }()
    private  let coinsButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.coin.title,
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
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.trending.title,
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
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.exchange.title,
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
        label.text = LocalizableKey.Home.name.title
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    private let volumeLabel: UILabel = {
       let label = UILabel()
        label.text = "24s %"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = LocalizableKey.Home.price.title
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    var stackView: UIStackView!
    var coinAndTrendingStackView: UIStackView!
    
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
        setupCollectionView()
    }
    private func setupHeaderView() {
        addSubview(homeHeaderView)
        homeHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    private func setupCollectionView() {
        collectionView.delegate = homeVM
        collectionView.dataSource = homeVM
        collectionView.isHidden = false
        collectionView.alpha  = 1
        addSubview(collectionView)
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
        var exchangeStakView = UIStackView(arrangedSubviews: [exchangeButton,exchangeBarView])
        exchangeStakView.axis = .vertical
        
        stackView = UIStackView(arrangedSubviews: [coinStackView,trendingStackView,exchangeStakView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        coinAndTrendingStackView = UIStackView(arrangedSubviews: [marketRankLabel,nameLabel,volumeLabel,priceLabel])
        coinAndTrendingStackView.spacing = 8
    
        addSubViews(stackView,
        coinAndTrendingStackView)
        coinAndTrendingStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-8)
        }
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
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(75)
        }
        volumeLabel.snp.makeConstraints { make in
            make.width.equalTo(165)
        }
        marketRankLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
    }
    private func setupExchangeStackView() {
        volumeLabel.text = "Skor"
        priceLabel.text = LocalizableKey.Home.volume.title
        nameLabel.snp.remakeConstraints { make in
            make.width.equalTo(125)
        }
        nameLabel.textAlignment = .right
        volumeLabel.snp.remakeConstraints({ make in
            make.width.equalTo(90)
        })
        volumeLabel.textAlignment = .right
        priceLabel.font = .systemFont(ofSize: 11)
    }
    private func setupCoinAndTrendingStackView() {
        volumeLabel.text = "24s %"
        priceLabel.text = LocalizableKey.Home.price.title
        nameLabel.textAlignment = .center
        volumeLabel.textAlignment = .center
        priceLabel.font = .systemFont(ofSize: 12)
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(75)
        }
        volumeLabel.snp.makeConstraints { make in
            make.width.equalTo(165)
        }
        marketRankLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
        }

    }
    private func setTitleColor(button: UIButton,color: UIColor) {
        if button == coinsButton {
            button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.coin.title,
                                                              attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                           .foregroundColor: color]), for: .normal)
            coinsBarView.backgroundColor = color
        } else if button == trendingButton {
            button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.trending.title,
                                                                 attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                              .foregroundColor: color]), for: .normal)
            trendingBarView.backgroundColor = color
        } else if button == exchangeButton {
            button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.exchange.title,
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
        trendingButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.coin.title,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        trendingBarView.backgroundColor = .lightGray
        exchangeButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.exchange.title,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        exchangeBarView.backgroundColor = .lightGray
        homeVM.callApi(requestType: .coin)
        setupCoinAndTrendingStackView()
    }
    @objc private func didTapTrendingButton(_ sender: UIButton) {
        setTitleColor(button: sender, color: .systemBlue)
        coinsButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.coin.title,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        coinsBarView.backgroundColor = .lightGray
        exchangeButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.exchange.title,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        exchangeBarView.backgroundColor = .lightGray
        homeVM.callApi(requestType: .trending)
        setupCoinAndTrendingStackView()
    }
    @objc private func didTapExchangeButton(_ sender: UIButton) {
        setTitleColor(button: sender, color: .systemBlue)
        coinsButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.coin.title,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        coinsBarView.backgroundColor = .lightGray
        trendingButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Home.trending.title,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                          .foregroundColor: UIColor.systemGray]), for: .normal)
        trendingBarView.backgroundColor = .lightGray
        homeVM.callApi(requestType: .exchange)
        setupExchangeStackView()
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
