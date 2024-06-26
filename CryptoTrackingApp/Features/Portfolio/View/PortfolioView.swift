//
//  PortfolioView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 10.04.2024.
//

import UIKit
import SnapKit

protocol PortfolioViewProtocol: AnyObject {
    func didTapAddAsset()
    func goToEditAssetVC(asset: Asset)
}

final class PortfolioView: UIView {
    // MARK: - UIElements
    private let headerContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 12
        view.layer.shadowOffset = .init(width: -4, height: 4)
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.Portfolio.total.title
        label.font = .systemFont(ofSize: 16,weight: .regular)
        return label
    }()
    private let totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 5652,2"
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private  let addAssetButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: ImageKey.Portfolio.addAsset.rawValue), for: .normal)
        button.addTarget(self, action: #selector(didTapAddAssetButton), for: .touchUpInside)
        return button
    }()
    private  let currentAssetButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Portfolio.currentAsset.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemBlue]), for: .normal)
       button.addTarget(self, action: #selector(didTapCurrentAssetButton), for: .touchUpInside)
        return button
    }()
    private  let activityButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.Portfolio.activity.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemGray]), for: .normal)
       button.addTarget(self, action: #selector(didTapActivityButton), for: .touchUpInside)
        return button
    }()
    private let assetTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.Portfolio.asset.title
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.Portfolio.price.title
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let pieceCoinTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.Portfolio.piece.title
        label.font = .systemFont(ofSize: 18,weight: .medium)
        return label
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: PortfolioTableViewCell.identifier)
        tableView.register(PortfolioActivityTableViewCell.self, forCellReuseIdentifier: PortfolioActivityTableViewCell.identifier)
        return tableView
    }()
    private var stackView: UIStackView!
    // MARK: - Properties
     let portfolioVM = PortfolioViewModel()
    weak var delegate: PortfolioViewProtocol?
    
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
extension PortfolioView {
    private func setup(){
        portfolioVM.delegate = self
        addConstraint()
        setupCollectionView()
    }
    private func addConstraint() {
        let headerStackView = UIStackView(arrangedSubviews: [totalTitleLabel,totalPriceValueLabel,UIView(),addAssetButton])
        headerStackView.axis = .horizontal
        headerStackView.spacing = 10
        headerContainer.addSubview(headerStackView)

        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        headerContainer.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(60)
        }
        let buttonStackView = UIStackView(arrangedSubviews: [currentAssetButton,activityButton,UIView()])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 25
        let titleStackView = UIStackView(arrangedSubviews: [assetTitleLabel,UIView(),UIView(),priceTitleLabel,pieceCoinTitleLabel,UIView()])
        titleStackView.axis = .horizontal
        titleStackView.distribution = .equalSpacing
        stackView = UIStackView(arrangedSubviews: [headerContainer,buttonStackView,UIView(),titleStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    private func setupCollectionView() {
        tableView.delegate = portfolioVM
        tableView.dataSource = portfolioVM
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = false
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    func didReloadTableView() {
        portfolioVM.fetchAssetData()
    }
}
// MARK: - Selectors
extension PortfolioView {
    @objc
    private func didTapCurrentAssetButton(){
        portfolioVM.isShowActivityCell = false
        didReloadData()
        activityButton.tintColor = .systemGray
        activityButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Portfolio.activity.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemGray]), for: .normal)
        currentAssetButton.tintColor = .systemBlue
        currentAssetButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Portfolio.currentAsset.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemBlue]), for: .normal)
    }
    @objc
    private func didTapActivityButton(){
        portfolioVM.isShowActivityCell = true
        portfolioVM.fetchAssetActivity { result in
            if result {
                self.didReloadData()
            }
        }
        currentAssetButton.tintColor = .systemGray
        currentAssetButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Portfolio.currentAsset.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                                  .foregroundColor: UIColor.systemGray]), for: .normal)
        activityButton.tintColor = .systemBlue
        activityButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.Portfolio.activity.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                                                            .foregroundColor: UIColor.systemBlue]), for: .normal)
    }
    @objc
    private func didTapAddAssetButton() {
        delegate?.didTapAddAsset()
    }
}
// MARK: - PortfolioViewModelProtocol
extension PortfolioView: PortfolioViewModelProtocol {
    func didReloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
            strongSelf.totalPriceValueLabel.text = "$"+strongSelf.portfolioVM.assets.reduce(0, { $0 + $1.totalPrice }).rounded(toDecimalPlaces: 2)
        }
    }
    func goToEditAssetVC(asset: Asset) {
        delegate?.goToEditAssetVC(asset: asset)
    }
}
