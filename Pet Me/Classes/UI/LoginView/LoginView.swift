//
//  LoginView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: class {
    func didTapLoginButton(email: String, password: String)
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private let emailTextField: RegistrationTextField = {
        let tf = RegistrationTextField(text: "Email или телефон")
        
        return tf
    }()
    
    private let passwordTextField: RegistrationTextField = {
        let tf = RegistrationTextField(text: "Пароль")
        tf.textField.textContentType = .password
        return tf
    }()
    
    private let textFieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        let mutableString = NSMutableAttributedString()
        let string = NSAttributedString(string: "Впервые здесь? ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        let registrationString = NSAttributedString(string: "Зарегистрироваться", attributes: [NSAttributedString.Key.foregroundColor: UIColor.link])
        mutableString.append(string)
        mutableString.append(registrationString)
        
        label.attributedText = mutableString
        return label
    }()
    
    private let loginButton: GradientButton = {
        let button = GradientButton()
        button.layer.cornerRadius = 10
        button.setTitle("Войти", for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [emailTextField, passwordTextField].forEach({ textFieldsStack.addArrangedSubview($0) })
        
        emailTextField.textField.delegate = self
        passwordTextField.textField.delegate = self

        addSubview(textFieldsStack)
        
        textFieldsStack.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(140)
        })
        
        setupLabel()
        setupLoginButton()
    }
    
    private func setupLabel() {
        addSubview(registrationLabel)
        registrationLabel.snp.makeConstraints({
            $0.top.equalTo(textFieldsStack.snp.bottom).offset(5)
            $0.leading.equalTo(textFieldsStack).inset(5)
        })
    }
    
    private func setupLoginButton() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        addSubview(loginButton)
        loginButton.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        })
    }
    
    
    @objc private func loginButtonTapped() {
        guard let email = emailTextField.textField.text, let password = passwordTextField.textField.text else { return }
        
        delegate?.didTapLoginButton(email: email, password: password)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == emailTextField.textField {
            emailTextField.isValid(text.isValidEmail)
        } else {
            passwordTextField.isValid(text.isValidPhone)
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
