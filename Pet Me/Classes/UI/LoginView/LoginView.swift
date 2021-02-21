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
    
    private let publishPhoneSubject = PublishSubject<String>()
    private let publishCodeSubject = PublishSubject<String>()
    
    var phoneTextFieldObservable: Observable<String> {
        return publishPhoneSubject.asObservable()
    }
    
    var codeTextFieldObservable: Observable<String> {
        return publishCodeSubject.asObservable()
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 140, height: 140)
    }
    
    private let disposeBag = DisposeBag()
    
    private let phoneTextField: RegistrationTextField = {
        let tf = RegistrationTextField(validationStrategy: PhoneValidation(), text: .phone)
        tf.textField.autocorrectionType = .no
        tf.textField.textContentType = .telephoneNumber
        return tf
    }()
    
    private let codeTextField: RegistrationTextField = {
        let tf = RegistrationTextField(validationStrategy: ConfirmationCodeValidationStrategy(), text: .confirmCodeButtonTitle)
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
    
    private let textFieldsAccessoryView = UIView()
    
    private let confirmPhoneButton = UIButton.createDisabledButton(withTitle: .requestCodePhoneButtonTitle)
    private let confirmCodeButton = UIButton.createDisabledButton(withTitle: .confirmCodeButtonTitle)
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        confirmCodeButton.isHidden = true
        
        textFieldsAccessoryView.backgroundColor = .clear
        textFieldsAccessoryView.addSubview(confirmPhoneButton)
        textFieldsAccessoryView.addSubview(confirmCodeButton)
        
        textFieldsAccessoryView.frame = .init(x: 0, y: 0, width: phoneTextField.frame.width, height: 60)
        
        confirmPhoneButton.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(10)
        })
        
        confirmCodeButton.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(10)
        })
        
        addSubview(textFieldsStack)
        
        [phoneTextField, codeTextField].forEach {
            textFieldsStack.addArrangedSubview($0)
            $0.textField.delegate = self
            $0.textField.inputAccessoryView = textFieldsAccessoryView
        }
        
        textFieldsStack.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        backgroundColor = .clear
        setupConfrimPhoneButton()
        setupConfirmCodeButton()
    }
    
    func animateCodeTextField(hide: Bool) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.codeTextField.alpha = hide ? 0 : 1
        }, completion: { _ in
            guard !hide else { return }
            self.codeTextField.textField.becomeFirstResponder()
        })
    }
    
    private func animateButtonTransition(toCode: Bool) {
        let fromView = toCode ? confirmPhoneButton : confirmCodeButton
        let toView = toCode ? confirmCodeButton : confirmPhoneButton
        
        UIView.transition(from: fromView, to: toView, duration: 0.5, options: [.transitionCrossDissolve, .showHideTransitionViews], completion: nil)
    }
    
    private func setupConfrimPhoneButton() {
        
        confirmPhoneButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] observer in
            guard let self = self else { return }
            
            if let text = self.phoneTextField.textField.text {
                self.publishPhoneSubject.onNext(text)
            }
            
        }).disposed(by: disposeBag)
        
        phoneTextField.isValidSubject.subscribe(onNext: { [weak self] isValid in
            guard let self = self else { return }
            self.confirmPhoneButton.backgroundColor = isValid ? .appLightGreen : .systemGray4
            self.confirmPhoneButton.isUserInteractionEnabled = isValid
        }).disposed(by: disposeBag)
    }
    
    private func setupConfirmCodeButton() {
        
        confirmCodeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] observer in
            guard let self = self else { return }
            
            if let text = self.codeTextField.textField.text {
                self.publishCodeSubject.onNext(text)
            }
            
        }).disposed(by: disposeBag)
        
        codeTextField.isValidSubject.subscribe(onNext: { [weak self] isValid in
            guard let self = self else { return }
            self.confirmCodeButton.backgroundColor = isValid ? .appLightGreen : .systemGray4
            self.confirmCodeButton.isUserInteractionEnabled = isValid
        }).disposed(by: disposeBag)
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case phoneTextField.textField:
            guard let text = textField.text else { return false }
            phoneTextField.validate(text: text)
            if !codeTextField.isHidden {
                animateCodeTextField(hide: true)
            }
            return true
        case codeTextField.textField:
            codeTextField.validate(text: string)
        default: ()
        }
        
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateButtonTransition(toCode: textField == codeTextField.textField)
    }
}
