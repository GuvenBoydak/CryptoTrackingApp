//
//  LoginView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func pushToRootController()
    func pushToRegisterController()
}

final class LoginView: UIView {
    // MARK: - UIElements
    private let LoginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.login.login.title
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private let emailTextField: CustomTextField = {
       let textfield = CustomTextField(padding: 10)
        textfield.placeholder = LocalizableKey.register.email.title
        textfield.backgroundColor = .tertiarySystemFill
        textfield.textAlignment = .center
        textfield.layer.cornerRadius = 12
        textfield.addTarget(self, action: #selector(didEditEmailTextField(_:)), for: .editingChanged)
        return textfield
    }()
    private let passwordTextField: CustomTextField = {
       let textfield = CustomTextField(padding: 10)
        textfield.placeholder = LocalizableKey.register.password.title
        textfield.backgroundColor = .tertiarySystemFill
        textfield.textAlignment = .center
        textfield.layer.cornerRadius = 12
        textfield.addTarget(self, action: #selector(didEditPasswordTextField(_:)), for: .editingChanged)
        return textfield
    }()
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.login.login.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                                  .foregroundColor: UIColor.gray]),
                                  for: .normal)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
        return button
    }()
    private let registerAddButton: UIButton = {
       let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.login.clickRegister.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                  .foregroundColor: UIColor.systemBlue]),
                                  for: .normal)
        button.addTarget(self, action: #selector(didTappedRegisterAddButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Properties
    private let loginVM = LoginViewModel()
    weak var delegate: LoginViewProtocol?
    
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
extension LoginView {
    private func setup() {
        addConstraint()
    }
    private func addConstraint() {
        addSubview(LoginTitleLabel)
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,registerAddButton])
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        LoginTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top).offset(-24)
            make.centerX.equalTo(snp.centerX)
         }
       emailTextField.snp.makeConstraints { make in
           make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
    }
    private func checkTextField() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        
        loginButton.isEnabled = true
        loginButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.login.login.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                                  .foregroundColor: UIColor.label]),
                                             for: .normal)
    }
}
// MARK: - Selector
extension LoginView {
    @objc
    private func didEditEmailTextField(_ textField: UITextField) {
       let validated = loginVM.validateEmail(text: textField.text ?? "")
        if validated {
            checkTextField()
        }
    }
    @objc
    private func didEditPasswordTextField(_ textField: UITextField) {
       let validated = loginVM.validatePassword(text: textField.text ?? "")
        if validated {
            checkTextField()
        }
    }
    @objc
    private func didTappedLoginButton() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        loginVM.loginProcess(email: email, Password: password) { [weak self] result in
            if result {
                self?.delegate?.pushToRootController()
            }
            // TODO: - Alert show
        }
    }
    @objc
    private func didTappedRegisterAddButton() {
        delegate?.pushToRegisterController()
    }
}
