//
//  PriceChangeView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit

class PriceChangeView: UIView {

    // MARK: - UIElements
    private let title24sLabel: UILabel = {
       let label = UILabel()
        label.text = "24 saat"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let value24sLabel: UILabel = {
       let label = UILabel()
        label.text = "+2,05"
        label.textColor = .red
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    private let title7dayLabel: UILabel = {
       let label = UILabel()
        label.text = "7 gün"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let value7dayLabel: UILabel = {
       let label = UILabel()
        label.text = "-3,65"
        label.textColor = .red
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    private let title30dayLabel: UILabel = {
       let label = UILabel()
        label.text = "30 gün"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let value30dayLabel: UILabel = {
       let label = UILabel()
        label.text = "+5,36"
        label.textColor = .red
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    private let title90dayLabel: UILabel = {
       let label = UILabel()
        label.text = "90 gün"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let value90dayLabel: UILabel = {
       let label = UILabel()
        label.text = "+1,65"
        label.textColor = .green
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    private let titleThisYearLabel: UILabel = {
       let label = UILabel()
        label.text = "bu yıl"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let valueThisYearLabel: UILabel = {
       let label = UILabel()
        label.text = "+15,66"
        label.textColor = .green
        label.font = .systemFont(ofSize: 14,weight: .regular)
        return label
    }()
    // MARK: - Properties
    
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
extension PriceChangeView {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        let firststackView = UIStackView(arrangedSubviews: [
        title24sLabel,title7dayLabel,title30dayLabel,title90dayLabel,titleThisYearLabel])
        firststackView.axis = .horizontal
        firststackView.spacing = 10
        firststackView.distribution = .equalCentering
        let secoundtstackView = UIStackView(arrangedSubviews: [
        value24sLabel,value7dayLabel,value30dayLabel,value90dayLabel,valueThisYearLabel])
        secoundtstackView.axis = .horizontal
        secoundtstackView.spacing = 10
        secoundtstackView.distribution = .equalCentering
        let stackView = UIStackView(arrangedSubviews: [firststackView,secoundtstackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    func configure(model: CoinDetail) {
        value24sLabel.text = "\(model.marketData.priceChangePercentage24H.rounded(toDecimalPlaces: 2))%"
        value24sLabel.textColor = setTextColor(priceChange: model.marketData.priceChangePercentage24H)
        value7dayLabel.text = "\(model.marketData.priceChangePercentage7D.rounded(toDecimalPlaces: 2))%"
        value7dayLabel.textColor = setTextColor(priceChange: model.marketData.priceChangePercentage7D)
        value30dayLabel.text = "\(model.marketData.priceChangePercentage30D.rounded(toDecimalPlaces: 2))%"
        value30dayLabel.textColor = setTextColor(priceChange: model.marketData.priceChangePercentage30D)
        value90dayLabel.text = "\(model.marketData.priceChangePercentage200D.rounded(toDecimalPlaces: 2))%"
        value90dayLabel.textColor = setTextColor(priceChange: model.marketData.priceChangePercentage200D)
        valueThisYearLabel.text = "\(model.marketData.priceChangePercentage1Y.rounded(toDecimalPlaces: 2))%"
        valueThisYearLabel.textColor = setTextColor(priceChange: model.marketData.priceChangePercentage1Y)
    }
    func setTextColor(priceChange: Double) -> UIColor {
        if priceChange.description.contains("-") {
            return .systemRed
        } else {
            return .systemGreen
        }
    }
}
