//
//  RegisterView.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import UIKit
protocol RegisterViewProtocol: AnyObject {
    func didTappedImageTapGesture()
    func didFinishImageTapGesture()
    func pushToRootController()
}

final class RegisterView: UIView {
    // MARK: - UIElements
    private let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.layer.cornerRadius = 50
        view.layer.shadowOffset = .init(width: -3, height: 3)
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.2
        return view
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: ImageKey.Home.person.rawValue)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    private let createTitleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizableKey.register.create.title
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    private let usernameTextField: CustomTextField = {
        let textfield = CustomTextField(padding: 10)
        textfield.placeholder = LocalizableKey.register.username.title
        textfield.backgroundColor = .tertiarySystemFill
        textfield.textAlignment = .center
        textfield.layer.cornerRadius = 12
        textfield.addTarget(self, action: #selector(didEditUsernameTextField(_:)), for: .editingChanged)
        return textfield
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
    private let registerAddButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: LocalizableKey.register.register.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                                  .foregroundColor: UIColor.gray]),
                                  for: .normal)
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    // MARK: - Properties
    private let registerVM = RegisterViewModel()
    weak var delegate: RegisterViewProtocol?
    
    
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
extension RegisterView {
    private func setup() {
        backgroundColor = .systemBackground
        addConstraint()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        imageContainer.addGestureRecognizer(tapGesture)
    }
    private func addConstraint() {
        imageContainer.addSubview(image)
        let stackView = UIStackView(arrangedSubviews: [imageContainer,createTitleLabel,usernameTextField,emailTextField,passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        addSubViews(imageContainer,stackView,registerAddButton)
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY).offset(-50)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        registerAddButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(50)
        }
        image.snp.makeConstraints { make in
            make.centerX.equalTo(imageContainer.snp.centerX)
            make.centerY.equalTo(imageContainer.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        imageContainer.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.width.equalTo(140)
            make.top.equalTo(snp.top).offset(30)
            make.centerX.equalTo(snp.centerX)
        }
    }
    private func checkTextField() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let image = image.image else { return }
        
        registerAddButton.isEnabled = true
        registerAddButton.setAttributedTitle(NSAttributedString(string: LocalizableKey.register.register.title,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium),
                                                                  .foregroundColor: UIColor.label]),
                                             for: .normal)
    }
}
//MARK: - Selectors
extension RegisterView {
    @objc
    private func didEditEmailTextField(_ textField: UITextField) {
       let validated = registerVM.validateEmail(text: textField.text ?? "")
        if validated {
            checkTextField()
        }
    }
    @objc
    private func didEditUsernameTextField(_ textField: UITextField) {
        checkTextField()
    }
    @objc
    private func didEditPasswordTextField(_ textField: UITextField) {
       let validated = registerVM.validatePassword(text: textField.text ?? "")
        if validated {
            checkTextField()
        }
    }
    @objc
    private func imageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTappedImageTapGesture()
    }
    @objc
    private func didTapRegisterButton() {
        guard let imageData = image.image?.jpegData(compressionQuality: 1.0),
              let username = usernameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        let registerRequest = RegisterRequest(username: username,
                                              email: email,
                                              password: password,
                                              imageData: imageData)
        registerVM.registerAndCreateUser(request: registerRequest) { [weak self] result in
            if result {
                self?.delegate?.pushToRootController()
            }
            // TODO: - Alert Show
        }
    }
}
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegisterView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.image.image = image
        
        delegate?.didFinishImageTapGesture()
    }
}

