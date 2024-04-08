//
//  HomeExchangeCollectionViewCell.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 8.04.2024.
//

import UIKit
import SnapKit

final class HomeExchangeCollectionViewCell: UICollectionViewCell {
    static let identitifier = "HomeExchangeCollectionViewCell"
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
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGreen
        return label
    }()
    private let totalVolumeLabel: UILabel = {
        let label = UILabel()
        label.text = "$1,35 T"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
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
extension HomeExchangeCollectionViewCell {
    private func setup() {
        setupUIElement()
    }
    private func setupUIElement(){
        let stackView = UIStackView(arrangedSubviews: [image,nameLabel,scoreLabel,totalVolumeLabel])
        stackView.spacing = 8

        addSubViews(countLabel,stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalTo(countLabel.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-8)
        }
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(image.snp.centerY)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(20)
        }
        image.snp.makeConstraints { make in
            make.width.equalTo(32)
            make.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(185)
        }
    }
    func configure(model: Exchange) {
        countLabel.text = "\(model.trustScoreRank)"
        nameLabel.text = model.name
        scoreLabel.text = "\(model.trustScore)"
        totalVolumeLabel.text = "\(model.tradeVolume24HBtc.rounded(toDecimalPlaces: 0)) BTC"
        if let url = URL(string: model.image) {
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
