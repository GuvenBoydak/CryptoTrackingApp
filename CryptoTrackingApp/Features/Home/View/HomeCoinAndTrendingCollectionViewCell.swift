//
//  HomeCollectionViewCell.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 5.04.2024.
//

import UIKit
import DGCharts
import SwiftSVG

final class HomeCoinAndTrendingCollectionViewCell: UICollectionViewCell {
    static let identitfier = "HomeCoinAndTrendingCollectionViewCell"
    // MARK: - UIElements
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        return label
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        return label
    }()
    private let totalMarketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "$1,35 T"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    let chartView: LineChartView = {
        let chartV = LineChartView()
        chartV.pinchZoomEnabled = false
        chartV.setScaleEnabled(true)
        chartV.xAxis.enabled = false
        chartV.drawGridBackgroundEnabled = false
        chartV.leftAxis.enabled = false
        chartV.rightAxis.enabled = false
        return chartV
    }()
    private var chartImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$66,050"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        return label
    }()
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+0,40%"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    var stackView: UIStackView!
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
extension HomeCoinAndTrendingCollectionViewCell {
    private func setup() {
        setupUIElement()
    }
    private func setupUIElement() {
        let imageStackView = UIStackView(arrangedSubviews: [image])
        let nameAndTotalCapStackView = UIStackView(arrangedSubviews: [nameLabel,totalMarketCapLabel])
        nameAndTotalCapStackView.axis = .vertical
        nameAndTotalCapStackView.distribution = .fillEqually
        let imageAndName = UIStackView(arrangedSubviews: [imageStackView,nameAndTotalCapStackView])
        imageAndName.axis = .horizontal
        imageAndName.spacing = 10
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel,priceChangeLabel])
        priceStackView.axis = .vertical
        stackView = UIStackView(arrangedSubviews: [imageAndName,chartView,chartImage,priceStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        addSubViews(countLabel,
                    stackView)
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(image.snp.centerY)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(20)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(countLabel.snp.trailing).offset(4)
        }
        image.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(40)
        }
        chartImage.snp.makeConstraints { make in
            make.width.equalTo(125)
            make.height.equalTo(40)
        }
        chartView.snp.makeConstraints { make in
            make.width.equalTo(125)
            make.height.equalTo(40)
        }
    }
    func configure(model: Codable) {
        if let coin = model as? Coin {
            chartImage.isHidden = true
            chartView.isHidden = false
            countLabel.text = "\(coin.marketCapRank)"
            if let url = URL(string: coin.image) {
                ImageLoader.shared.downloadImage(url) { [weak self] result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self?.image.image = UIImage(data: data)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
            nameLabel.text = coin.symbol.uppercased()
            totalMarketCapLabel.text = coin.marketCap.formattedWithAbbreviations()
            configureChartView(price: coin.sparklineIn7D.price,priceChange: coin.priceChangePercentage24H)
            priceLabel.text = coin.currentPrice.asCurrencyWith6Decimals()
            priceChangeLabelConfigure(value: coin.priceChangePercentage24H)
        } else if let trending = model as? TrendingCoin {
            chartView.isHidden = true
            chartImage.isHidden = false
            countLabel.text = "\(trending.marketCapRank)"
            if let url = URL(string: trending.small) {
                ImageLoader.shared.downloadImage(url) { [weak self] result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self?.image.image = UIImage(data: data)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
            nameLabel.text = trending.symbol.uppercased()
            totalMarketCapLabel.text = trending.data.marketCap.removeFirstAndFormatted()
            
            if let url = URL(string: trending.data.sparkline) {
                DispatchQueue.global().async {
                let image = UIView(svgURL: url) { [weak self] (svgLayer) in
                        guard let strong = self else { return }
                        svgLayer.fillColor = UIColor.clear.cgColor
                        svgLayer.resizeToFit(strong.chartView.bounds)
                    }
                    DispatchQueue.main.async {
                        self.chartImage.subviews.forEach { $0.removeFromSuperview() }
                        self.chartImage.addSubview(image)
                    }
               }
            }
            priceLabel.text = trending.data.price.asCurrencyWith6Decimals()
            if let data = trending.data.priceChangePercentage24H["usd"] {
                priceChangeLabelConfigure(value: data)
            }
        }
    }
    private func priceChangeLabelConfigure(value: Double) {
        if (value.description.contains("-")) {
            priceChangeLabel.textColor = .systemRed
            priceChangeLabel.text = "\(value.rounded(toDecimalPlaces: 2))%"
        } else {
            priceChangeLabel.textColor = .systemGreen
            priceChangeLabel.text = "+\(value.rounded(toDecimalPlaces: 2))%"
        }
    }
    private func configureChartView(price: [Double],priceChange: Double){
        var entries = [ChartDataEntry]()
        
        for (index, value) in price.enumerated() {
            entries.append(.init(x: Double(index), y: value))
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "")
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        if priceChange.description.contains("-") {
            dataSet.fillColor = .systemRed
        } else {
            dataSet.fillColor = .systemGreen
        }
        
        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }
}

