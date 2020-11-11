//
//  LoginView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginViewDelegate: class {
    func didTapLoginButton(email: String, password: String)
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private let publishSubject = PublishSubject<String>()
    
    var phoneTextFieldObservable: Observable<String> {
        return publishSubject.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    private let emailTextField: RegistrationTextField = {
        let tf = RegistrationTextField(text: "Номер")
        tf.snp.makeConstraints({ $0.height.equalTo(70) })
        return tf
    }()
    
    private let codeTextField: RegistrationTextField = {
        let tf = RegistrationTextField(text: "Подтвердите код")
        tf.isHidden = true
        tf.alpha = 0
        tf.textField.keyboardType = .numberPad
        tf.textField.returnKeyType = .done
        tf.textField.textContentType = .oneTimeCode
        return tf
    }()
    
    private let textFieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
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

        textFieldsStack.addArrangedSubview(emailTextField)
        textFieldsStack.addArrangedSubview(codeTextField)
        emailTextField.textField.delegate = self

        addSubview(textFieldsStack)
        
        textFieldsStack.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        })
        
        setupLoginButton()
    }
    
    func animateCodeTextFieldIn() {
        guard codeTextField.isHidden else { return }
        codeTextField.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: ({ [unowned self] in
            self.codeTextField.alpha = 1
            self.loginButton.transform = .init(translationX: self.loginButton.frame.origin.x, y: self.emailTextField.frame.height)
        }))
    }
    
    private func setupLoginButton() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints({
            $0.top.equalTo(emailTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        })
        
        loginButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] observer in
            if let text = self?.emailTextField.textField.text {
                self?.publishSubject.onNext(text)
            }
        }).disposed(by: disposeBag)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        emailTextField.isValid(text.isValidPhone)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
