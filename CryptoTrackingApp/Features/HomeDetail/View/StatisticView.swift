//
//  StatisticView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit
import SnapKit

final class StatisticView: UIView {
    // MARK: - UIElements
    private let marketCapLabel: UILabel = {
       let label = UILabel()
        label.text = "Piyasa deger"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let marketCapValueLabel: UILabel = {
       let label = UILabel()
        label.text = "11,354"
        label.font = .systemFont(ofSize: 16,weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    private let athTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "En Yüksek"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let athValueLabel: UILabel = {
       let label = UILabel()
        label.text = "73,500"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    private let lowestTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "EnDüşük"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let lowestValueLabel: UILabel = {
       let label = UILabel()
        label.text = "$0,00054"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    private let totalVolumeTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Total Hacim"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let totalVolumeValueLabel: UILabel = {
       let label = UILabel()
        label.text = "24,00"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    private let totalSupplyTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Total Arz"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let totalSupplyValueLabel: UILabel = {
       let label = UILabel()
        label.text = "21.67"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    private let circulatingSupplyTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Dolaşımdaki arz"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let circulatingSupplyValueLabel: UILabel = {
       let label = UILabel()
        label.text = "21,67"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16,weight: .regular)
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
extension StatisticView {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        let firsStackView = UIStackView(arrangedSubviews:
                                            [marketCapLabel,marketCapValueLabel,UIView(),athTitleLabel,athValueLabel,UIView(),lowestTitleLabel,lowestValueLabel])
        firsStackView.axis = .vertical
        firsStackView.spacing = 4
        let secondStackView = UIStackView(arrangedSubviews: [totalVolumeTitleLabel,totalVolumeValueLabel,UIView(),totalSupplyTitleLabel,totalSupplyValueLabel,UIView(),circulatingSupplyTitleLabel,circulatingSupplyValueLabel])
        secondStackView.axis = .vertical
        secondStackView.spacing = 4
        let stackView = UIStackView(arrangedSubviews: [firsStackView,UIView(),secondStackView])
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    func configure(model: Coin) {
        guard let totalSupply = model.totalSupply
            else { return }
        marketCapValueLabel.text = model.marketCap.formattedWithAbbreviations()
        athValueLabel.text = "$\(model.ath.rounded(toDecimalPlaces: 2))"
        lowestValueLabel.text = model.atl.asCurrencyWith6Decimals()
        totalVolumeValueLabel.text = model.totalVolume.formattedWithAbbreviations()
        totalSupplyValueLabel.text = "\(totalSupply.formattedWithAbbreviations().removeFirst(value: "$")) \(model.symbol.uppercased())"
        circulatingSupplyValueLabel.text = "\(model.circulatingSupply.formattedWithAbbreviations().removeFirst(value: "$")) \(model.symbol.uppercased())"

    }
}
