//
//  LoginViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import UIKit

final class LoginViewController: UIViewController {

    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Helpers
extension LoginViewController {
    private func setup() {
        loginView.delegate = self
        view.backgroundColor = .systemBackground
        addConstraint()
    }
    private func addConstraint() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func pushToRootController() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    func pushToRegisterController() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
