//
//  PortfolioCollectionViewCell.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import UIKit

final class PortfolioCollectionViewCell: UICollectionViewCell {
    static let identifier = "PortfolioCollectionViewCell"
    // MARK: - UIElements
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.layer.cornerRadius = 24
        return view
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: ImageKey.Home.person.rawValue)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Arbitrium"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let shortNameLabel: UILabel = {
        let label = UILabel()
        label.text = "ABR"
        label.font = .systemFont(ofSize: 13,weight: .regular)
        return label
    }()
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$1,52"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let currentPriceChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+2,10"
        label.font = .systemFont(ofSize: 13,weight: .regular)
        return label
    }()
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$1520"
        label.font = .systemFont(ofSize: 14,weight: .medium)
        return label
    }()
    private let pieceCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "1000 ABR"
        label.font = .systemFont(ofSize: 13,weight: .regular)
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
extension PortfolioCollectionViewCell {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        let nameStackView = UIStackView(arrangedSubviews: [nameTitleLabel,shortNameLabel])
        nameStackView.axis = .vertical
        nameStackView.spacing = 4
        let priceStackView = UIStackView(arrangedSubviews: [currentPriceLabel,currentPriceChangeLabel])
        priceStackView.axis = .vertical
        priceStackView.spacing = 4
        let totalAmountStackView = UIStackView(arrangedSubviews: [totalAmountLabel,pieceCoinLabel])
        totalAmountStackView.axis = .vertical
        totalAmountStackView.spacing = 4
        let stackView = UIStackView(arrangedSubviews: [image,nameStackView,UIView(),priceStackView,totalAmountStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        containerView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(8)
            make.leading.equalTo(containerView.snp.leading).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
        }
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(60)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        image.snp.makeConstraints { make in
            make.width.equalTo(35)
        }
    }
    func configure(model: Asset) {
        nameTitleLabel.text = model.name
        shortNameLabel.text = model.symbol.uppercased()
        currentPriceLabel.text = model.currentPrice?.asCurrencyWith6Decimals()

        if let priceChange = model.priceChange,
           priceChange.description.contains("-") {
            currentPriceChangeLabel.text = "-\(priceChange.rounded(toDecimalPlaces: 2))"
            currentPriceChangeLabel.textColor = .systemRed
        } else {
            currentPriceChangeLabel.textColor = .green
            currentPriceChangeLabel.text = "+\(model.priceChange?.rounded(toDecimalPlaces: 2) ?? "")"
        }
        totalAmountLabel.text = "$"+model.totalPrice.rounded(toDecimalPlaces: 2)
        pieceCoinLabel.text = "\(model.piece.doubleValue)"
        
        if let url = URL(string: model.imageUrl) {
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
    }
}
