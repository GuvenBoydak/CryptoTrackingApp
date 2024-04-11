//
//  SearchTableViewCell.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    static let identitifier = "SearchTableViewCell"
    // MARK: - UIElements
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: ImageKey.Home.person.rawValue)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    private let shortNameLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 65,995"
        label.textColor = .label
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    // MARK: - Properties
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
       setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }

}
// MARK: - Helpers
extension SearchTableViewCell {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        let stackView = UIStackView(arrangedSubviews: [shortNameLabel,nameLabel,priceLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        addSubViews(image,stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.height.lessThanOrEqualTo(30)
            make.centerY.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.height.lessThanOrEqualTo(30)
            make.width.lessThanOrEqualTo(30)
        }
    }
    func configure(model: Coin) {
        shortNameLabel.text = model.symbol.uppercased()
        nameLabel.text = model.name
        priceLabel.text = model.currentPrice.asCurrencyWith6Decimals()
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
        }
    }
}
