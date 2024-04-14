//
//  AddAssetView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 11.04.2024.
//

import UIKit
import FirebaseAuth

protocol AddAssetViewProtocol:AnyObject {
    func popToRootControlller()
}

final class AddAssetView: UIView {
    // MARK: - UIElements
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let pieceTexField: CustomTextField = {
        let textfield = CustomTextField(padding: 20)
        textfield.text = "0"
        textfield.backgroundColor = .tertiarySystemFill
        textfield.textAlignment = .center
        textfield.layer.cornerRadius = 12
        textfield.addTarget(self, action: #selector(didChangePriceTextField(_:)), for: .editingChanged)
        return textfield
    }()
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.addAsset.usd.title
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private  let currencyChangeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(didTapCurrencyChangeButton), for: .touchUpInside)
        return button
    }()
    private let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$1,52"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14,weight: .light)
        return label
    }()
    private let totalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.text =  LocalizableKey.addAsset.totalPrice.title
        label.font = .systemFont(ofSize: 15,weight: .light)
        return label
    }()
    private let priceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemFill
        view.layer.cornerRadius = 12
        return view
    }()
    private let totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 66,505"
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    private  let addAssetButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string:  LocalizableKey.addAsset.addAsset.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.label]), for: .normal)
        button.backgroundColor = .tertiarySystemFill
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapAddAssetButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Properties
    var coin: Coin?
    private var isUSD = true
    private let addAssetVM = AddAssetViewModel()
    weak var delegate: AddAssetViewProtocol?
    
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
extension AddAssetView {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        addSubview(coinNameLabel)
        coinNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview().offset(40)
        }
        let currencyStackView = UIStackView(arrangedSubviews: [currencyNameLabel,currencyChangeButton])
        currencyStackView.axis = .vertical
        currencyStackView.spacing = 2
        let pieceAndCurrencyStackview = UIStackView(arrangedSubviews: [UIView(),UIView(),UIView(),pieceTexField,UIView(),currencyStackView])
        pieceAndCurrencyStackview.axis = .horizontal
        pieceAndCurrencyStackview.distribution = .equalSpacing
        addSubview(pieceAndCurrencyStackview)
        pieceAndCurrencyStackview.snp.makeConstraints { make in
            make.top.equalTo(coinNameLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
        }
        pieceTexField.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(50)
        }
        priceContainer.addSubview(totalPriceValueLabel)
        let stackView = UIStackView(arrangedSubviews: [coinPriceLabel,UIView(),totalPriceTitleLabel,priceContainer,UIView(),UIView(),addAssetButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(pieceAndCurrencyStackview.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        totalPriceValueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        priceContainer.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(35)
        }
        addAssetButton.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(50)
        }
    }
    func configure() {
        guard let coin = coin else { return }
        coinNameLabel.text = coin.symbol.uppercased()
        totalPriceValueLabel.text = ""
        coinPriceLabel.text = "$\(coin.currentPrice.rounded(toDecimalPlaces: 2))"
    }
    private func clearUI() {
        pieceTexField.text = ""
        totalPriceValueLabel.text = ""
    }
}
// MARK: - Selectors
extension AddAssetView {
    @objc
    private func didTapCurrencyChangeButton() {
        if isUSD {
            coinNameLabel.text = "$"
            currencyNameLabel.text = coin?.symbol.uppercased()
            isUSD = false
        } else {
            coinNameLabel.text = coin?.symbol.uppercased()
            currencyNameLabel.text =  LocalizableKey.addAsset.usd.title
            isUSD = true
        }
    }
    @objc
    private func didChangePriceTextField(_ textField: UITextField) {
        let coinPriceValue = coinPriceLabel.text?.removeFirst(value: "$").replacingOccurrences(of: ",", with: ".")
        guard let value = Double(textField.text ?? "0"),
              let coinPrice = Double(coinPriceValue ?? "0") else { return }
        if isUSD {
            let amount = value * coinPrice
            totalPriceValueLabel.text = "$\(amount.rounded(toDecimalPlaces: 2))"
        } else {
            let amount = value / coinPrice
            totalPriceValueLabel.text = "\(amount.rounded(toDecimalPlaces: 2)) \(coin?.symbol.uppercased() ?? "")"
        }
    }
    @objc
    private func didTapAddAssetButton() {
        guard let coin = coin,
              let totalPrice = totalPriceValueLabel.text?.removeFirst(value: "$"),
              let piece = pieceTexField.text?.removeFirst(value: "$"),
              !totalPrice.isEmpty,
              !piece.isEmpty,
        let user = Auth.auth().currentUser else { return }
        let asset = Asset(id: coin.id,
                          userId: user.uid,
                          imageUrl: coin.image,
                          name: coin.name,
                          symbol: coin.symbol,
                          totalPrice: isUSD ? totalPrice.doubleValue : piece.doubleValue,
                          piece: isUSD ? piece.doubleValue : totalPrice.replacingOccurrences(of: "\(coin.symbol.uppercased())", with: "").doubleValue,
                          date: Date())
        addAssetVM.createAsset(asset: asset)
        clearUI()
        delegate?.popToRootControlller()
    }
}
