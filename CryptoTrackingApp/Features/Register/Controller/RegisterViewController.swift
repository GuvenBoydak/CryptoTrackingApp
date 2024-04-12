//
//  RegisterViewController.swift
//  CryptoTrackingApp
//
//  Created by Güven Boydak on 12.04.2024.
//

import UIKit

final class RegisterViewController: UIViewController {
    private let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
// MARK: - Helpers
extension RegisterViewController {
    private func setup() {
        registerView.delegate = self
        view.backgroundColor = .systemBackground
        addConstraint()
    }
    private func addConstraint() {
        view.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
// MARK: - RegisterViewProtocol
extension RegisterViewController: RegisterViewProtocol {
    func didTappedImageTapGesture() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = registerView
        
        present(imagePickerController, animated: true)
    }
    func didFinishImageTapGesture() {
        dismiss(animated: true)
    }
    func pushToRootController() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

