//
//  HomeDetailElementsView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit
import DGCharts

class HomeDetailElementsView: UIView {
    // MARK: - UIElements
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: ImageKey.Home.person.rawValue)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let marketCapTitle: UILabel = {
       let label = UILabel()
        label.text = "Market Cap"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let marketCapValueLabel: UILabel = {
       let label = UILabel()
        label.text = "1,40 T"
        label.font = .systemFont(ofSize: 14,weight: .regular)
        label.textAlignment = .center
        return label
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Bitcoin #1"
        label.font = .systemFont(ofSize: 15,weight: .medium)
        label.textAlignment = .left
        return label
    }()
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "$ 66,680"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.textColor = .systemGreen
        label.textAlignment = .left
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
        chartV.backgroundColor = .red
        return chartV
    }()
    private let priceTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Price"
        label.font = .systemFont(ofSize: 15,weight: .heavy)
        return label
    }()
    private let priceChangeView = PriceChangeView()
    private let statisticTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Statistic"
        label.font = .systemFont(ofSize: 15,weight: .heavy)
        return label
    }()
    private let statisticView = StatisticView()
    private let aboutTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "About"
        label.font = .systemFont(ofSize: 15,weight: .heavy)
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
extension HomeDetailElementsView {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        priceChangeView.backgroundColor = .tertiarySystemFill
        priceChangeView.layer.cornerRadius = 8
        statisticView.backgroundColor = .tertiarySystemFill
        statisticView.layer.cornerRadius = 8
        let marketCapStackView = UIStackView(arrangedSubviews: [marketCapTitle,marketCapValueLabel])
        marketCapStackView.axis = .vertical
        marketCapStackView.spacing = 4
        let namePriceStackView = UIStackView(arrangedSubviews: [nameLabel,priceLabel])
        namePriceStackView.axis = .vertical
        namePriceStackView.spacing = 4
        let marketAndNameStackView = UIStackView(arrangedSubviews: [marketCapStackView,namePriceStackView])
        marketAndNameStackView.axis = .horizontal
        marketAndNameStackView.distribution = .equalSpacing
        let headerStackView = UIStackView(arrangedSubviews: [image,marketAndNameStackView])
        headerStackView.axis = .horizontal
        headerStackView.spacing = 12
        let bodystackView = UIStackView(arrangedSubviews: [chartView,priceTitleLabel,priceChangeView,statisticTitleLabel,statisticView,aboutTitleLabel])
        bodystackView.axis = .vertical
        bodystackView.spacing = 10
        let stackView = UIStackView(arrangedSubviews: [headerStackView,bodystackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
        }
        image.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(50)
            make.width.greaterThanOrEqualTo(50)
        }
        chartView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(160)
        }
    }
    func configure(model: CoinDetail) {
      statisticView.configure(model: model)
        priceChangeView.configure(model: model)
        if let url = URL(string: model.image.small){
          // let sparklineData = model.sparklineIn7D {
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
          //  configureChartView(price: sparklineData.price, priceChange: model.marketData.priceChange24H)
        }
        marketCapValueLabel.text = model.marketData.marketCap["usd"]?.formattedWithAbbreviations()
        nameLabel.text = "\(model.name) #\(model.marketCapRank)"
        priceLabel.text = model.marketData.currentPrice["usd"]?.rounded(toDecimalPlaces: 2)
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

