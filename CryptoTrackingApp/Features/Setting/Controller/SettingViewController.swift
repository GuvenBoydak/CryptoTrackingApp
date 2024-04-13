//
//  SettingViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 4.04.2024.
//

import UIKit
import SwiftUI

final class SettingViewController: UIViewController {
    var settingSwiftUIView: UIHostingController<SettingSwiftUIView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}
//MARK: - Helpers
extension SettingViewController {
    private func setup() {
        view.backgroundColor = .systemBackground
        addSwiftUIController()
    }
    private func addSwiftUIController() {
        let settingSwiftUIView = UIHostingController(
            rootView: SettingSwiftUIView())
        addChild(settingSwiftUIView)
        settingSwiftUIView.didMove(toParent: self)
        
        settingSwiftUIView.rootView.delegate = self
        view.addSubview(settingSwiftUIView.view)
        settingSwiftUIView.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        self.settingSwiftUIView = settingSwiftUIView
    }
}
// MARK: - SettingSwiftUIViewProtocol
extension SettingViewController: SettingSwiftUIViewProtocol {
    func didTappedSignOutButton() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
