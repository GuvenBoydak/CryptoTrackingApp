//
//  HomeDetailView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 9.04.2024.
//

import UIKit
import SnapKit

class HomeDetailView: UIView {
    // MARK: - UIElements
    let homeDetailElemementsView = HomeDetailElementsView()
    private let aboutContainerView: UIView = {
       let view = UIView()
        return view
    }()
    private let descriptionTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "lorem ıpsun lorem ıpsun lorem lorem ıpsun ıpsun lorem ıpsun derter derete aksra ar"
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let linkButton: UIButton = {
       let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Linkler:    Source Kod,Social Media,Web Site",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 13,weight: .medium),
                                                                  .foregroundColor: UIColor.systemBlue]),
                                  for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapLinkButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Properties
    let homeDetailVM = HomeDetailViewModel()
    var coin: Coin?
    
    // MARK: - Life Cycle
    init(frame: CGRect,coin: Coin?) {
        self.coin = coin
        super.init(frame: frame)
        setup()
        if let coin = coin {
            homeDetailVM.fetchCoinById(id: coin.id) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.configure(model: data)
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Helpers
extension HomeDetailView {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        let aboutStackView = UIStackView(arrangedSubviews: [descriptionTitleLabel,linkButton])
        aboutStackView.axis = .vertical
        aboutStackView.spacing = 12
        aboutContainerView.addSubViews(aboutStackView)
        
        let stackView = UIStackView(arrangedSubviews: [homeDetailElemementsView,aboutStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    func configure(model: CoinDetail) {
        //descriptionTitleLabel.text = model.description.en
            var newModel = model
        if let coin = coin {
          //  newModel.setSparklineIn7D(sparklineIn7D: coin.sparklineIn7D)
            homeDetailElemementsView.configure(model: newModel)
        }
    }
}
// MARK: - Selectors
extension HomeDetailView {
    @objc
    private func didTapLinkButton() {
        
    }
}
