//
//  LoginView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

class LoginView: UIView {
    
    private let publishSubject = PublishSubject<[String: String]>()
    
    var phoneTextFieldObservable: Observable<[String: String]> {
        return publishSubject.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    private let phoneTextField: RegistrationTextField = {
        let tf = RegistrationTextField(validationStrategy: PhoneValidation(), text: "Номер")
        tf.textField.autocorrectionType = .no
        tf.textField.textContentType = .telephoneNumber
        tf.snp.makeConstraints({ $0.height.equalTo(70) })
        return tf
    }()
    
    private let codeTextField: RegistrationTextField = {
        let tf = RegistrationTextField(validationStrategy: ConfirmationCodeValidationStrategy(), text: "Подтвердите код")
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
    
    private let phoneConfirmButton = UIButton.createDisabledButton(withTitle: "Запросить код")
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let acessoryView = UIView()
        acessoryView.backgroundColor = .clear
        acessoryView.addSubview(phoneConfirmButton)
        acessoryView.frame = .init(x: 0, y: 0, width: phoneTextField.frame.width, height: 60)
        
        phoneConfirmButton.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(10)
        })
        
        phoneTextField.textField.delegate = self
        codeTextField.textField.delegate = self
        
        addSubview(textFieldsStack)
        
        [phoneTextField, codeTextField].forEach({
            textFieldsStack.addArrangedSubview($0)
            $0.textField.inputAccessoryView = acessoryView
        })
        
        textFieldsStack.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        })
        backgroundColor = .clear
        setupLoginButton()
    }
    
    func animateCodeTextField(hide: Bool) {
        if !hide {
            codeTextField.isHidden = false
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.codeTextField.alpha = hide ? 0 : 1
        }, completion: { _ in
            if hide {
                self.codeTextField.isHidden = true
                self.codeTextField.textField.text = ""
                return
            }
            self.codeTextField.becomeFirstResponder()
        })
    }
    
    private func setupLoginButton() {
        
        phoneConfirmButton.frame = .init(x: 0, y: 0, width: phoneTextField.frame.width - 20, height: 50)
        
        phoneConfirmButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] observer in
            
            guard let self = self else { return }
            
            if let text = self.phoneTextField.textField.text, let codeText = self.codeTextField.textField.text {
                
                if self.codeTextField.isHidden {
                    self.publishSubject.onNext(["phone": text])
                    self.codeTextField.textField.becomeFirstResponder()
                } else {
                    self.publishSubject.onNext(["phone": text, "code": codeText])
                    return
                }
            }
            
        }).disposed(by: disposeBag)
        
        [phoneTextField, codeTextField].forEach({
            $0.isValid.subscribe(onNext: { [weak self] element in
                guard let self = self else { return }
                self.phoneConfirmButton.backgroundColor = element ? .appLightGreen : .systemGray4
            }).disposed(by: disposeBag)
        })
        
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        switch textField {
        case phoneTextField.textField:
            phoneTextField.validate(text: text)
        case codeTextField.textField:
            codeTextField.validate(text: text)
        default: ()
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == phoneTextField.textField {
            if !codeTextField.isHidden {
                animateCodeTextField(hide: true)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case codeTextField.textField:
            phoneConfirmButton.setTitle("Подтвердить код", for: .normal)
            phoneConfirmButton.backgroundColor = textField.text?.count == 6 ? .appLightGreen : .systemGray4
        case phoneTextField.textField:
            phoneConfirmButton.setTitle("Запросить код", for: .normal)
        default:
            ()
        }
    }
    
    
}
