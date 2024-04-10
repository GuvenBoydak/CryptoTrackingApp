//
//  HomeDetailElementsView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit
import DGCharts

final class HomeDetailElementsView: UIView {
    // MARK: - UIElements
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.layer.cornerRadius = 8
        return view
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: ImageKey.Home.person.rawValue)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin "
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let shortNameLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = .systemFont(ofSize: 15,weight: .medium)
        label.textAlignment = .center
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 66,680"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.textColor = .systemGreen
        label.textAlignment = .center
        return label
    }()
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+2,53%"
        label.font = .systemFont(ofSize: 14,weight: .regular)
        label.textAlignment = .center
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
    private let statisticTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Statistic"
        label.font = .systemFont(ofSize: 18,weight: .heavy)
        return label
    }()
    private let statisticView = StatisticView()
    
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
        statisticView.backgroundColor = .tertiarySystemFill
        statisticView.layer.cornerRadius = 8
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel,shortNameLabel])
        nameStackView.axis = .vertical
        nameStackView.spacing = -18
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel,priceChangeLabel])
        priceStackView.axis = .vertical
        priceStackView.spacing = -18
        let marketAndNameStackView = UIStackView(arrangedSubviews: [nameStackView,priceStackView])
        marketAndNameStackView.axis = .horizontal
        marketAndNameStackView.distribution = .equalSpacing
        let headerStackView = UIStackView(arrangedSubviews: [image,marketAndNameStackView])
        headerStackView.axis = .horizontal
        headerStackView.spacing = 20
        containerView.addSubview(headerStackView)
        let bodystackView = UIStackView(arrangedSubviews: [chartView,statisticTitleLabel,statisticView])
        bodystackView.axis = .vertical
        bodystackView.spacing = 10
        let stackView = UIStackView(arrangedSubviews: [containerView,bodystackView])
        stackView.axis = .vertical
        stackView.spacing = 10

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
        }
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.bottom.equalToSuperview().offset(-4)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(shortNameLabel.snp.height)
        }
        shortNameLabel.snp.makeConstraints { make in
            make.height.equalTo(nameLabel.snp.height)
        }
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(priceChangeLabel.snp.height)
        }
        priceChangeLabel.snp.makeConstraints { make in
            make.height.equalTo(priceLabel.snp.height)
        }
        image.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(65)
            make.width.lessThanOrEqualTo(65)
        }
        chartView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(220)
        }
    }
    func configure(model: Coin) {
        statisticView.configure(model: model)
        nameLabel.text = "\(model.name) #\(model.marketCapRank)"
        shortNameLabel.text = model.symbol.uppercased()
        priceLabel.text = "$\(model.currentPrice.rounded(toDecimalPlaces: 2))"
        priceChangeLabel.text = "\(model.priceChangePercentage24H.rounded(toDecimalPlaces: 2))%"
        if model.priceChangePercentage24H.description.contains("-") {
            priceChangeLabel.textColor = .systemRed
        } else {
            priceChangeLabel.textColor = .systemGreen
        }
        if let url = URL(string: model.image){
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
            configureChartView(price: model.sparklineIn7D.price, priceChange: model.priceChangePercentage24H)
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

