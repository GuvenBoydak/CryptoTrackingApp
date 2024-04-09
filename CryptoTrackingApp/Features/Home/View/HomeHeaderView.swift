//
//  HomeHeaderView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import UIKit
import SnapKit


final class HomeHeaderView: UIView {
    // MARK: - UIElements
    let marketCapView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 30
        view.layer.shadowOffset = .init(width: -4, height: 4)
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let marketCapTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.HomeHeader.market.title
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let marketCapValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 2,526T"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    private let volumeView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 30
        view.layer.shadowOffset = .init(width: -4, height: 4)
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let volumeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.HomeHeader.volume.title
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let volumeValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 2,526T"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    private let dominanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 30
        view.layer.shadowOffset = .init(width: -4, height: 4)
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let dominanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.HomeHeader.dominance.title
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return label
    }()
    private let dominanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "% 45,6"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()

    var stackView: UIStackView!
    // MARK: - Properties
    let homeHeaderVM = HomeHeaderViewModel()

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        homeHeaderVM.fetchMarketData() { [weak self] model in
            DispatchQueue.main.async {
                self?.configure(model: model)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - UIElements
extension HomeHeaderView {
    private func setup() {
        setupUIElements()
    }
    private func setupUIElements() {
        stackView = UIStackView(arrangedSubviews: [marketCapView,volumeView,dominanceView])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        
        addSubViews(stackView,
                    marketCapTitleLabel,
                    marketCapValueLabel,
                    volumeTitleLabel,
                    volumeValueLabel,
                    dominanceTitleLabel,
                    dominanceValueLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        marketCapTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapView.snp.top).offset(12)
            make.centerX.equalTo(marketCapView.snp.centerX)
        }
        marketCapValueLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapTitleLabel.snp.bottom).offset(6)
            make.centerX.equalTo(marketCapTitleLabel.snp.centerX)
        }
        volumeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(volumeView.snp.top).offset(12)
            make.centerX.equalTo(volumeView.snp.centerX)
        }
        volumeValueLabel.snp.makeConstraints { make in
            make.top.equalTo(volumeTitleLabel.snp.bottom).offset(6)
            make.centerX.equalTo(volumeTitleLabel.snp.centerX)
        }
        dominanceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dominanceView.snp.top).offset(12)
            make.centerX.equalTo(dominanceView.snp.centerX)
        }
        dominanceValueLabel.snp.makeConstraints { make in
            make.top.equalTo(dominanceTitleLabel.snp.bottom).offset(6)
            make.centerX.equalTo(dominanceTitleLabel.snp.centerX)
        }
    }
    private func configure(model: MarketData?) {
        guard let data = model,
        let marketCap = data.totalMarketCap["usd"],
        let totalVolume = data.totalVolume["usd"],
        let dominance = data.marketCapPercentage["btc"] else {
            return
        }
        marketCapValueLabel.text = marketCap.formattedWithAbbreviations()
        volumeValueLabel.text = totalVolume.formattedWithAbbreviations()
        dominanceValueLabel.text = "% \(dominance.rounded(toDecimalPlaces: 1))"
    }
}


