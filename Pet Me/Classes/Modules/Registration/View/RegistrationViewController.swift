//
//  RegistrationRegistrationViewController.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import RxSwift
import AuthenticationServices
import GoogleSignIn
import Firebase
import SnapKit

class RegistrationViewController: ControllerWithSideMenu {

    
    private let loginView = LoginView()
    private let disposeBag = DisposeBag()
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "или"
        label.textColor = .tertiaryLabel
        return label
    }()
    
    var output: RegistrationViewOutput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    private func setupSubscriptions() {
        loginView.phoneTextFieldObservable.subscribe(onNext: { [weak self] text in
            self?.output.handlePhoneAuth(phone: text)
        }).disposed(by: disposeBag)
    }
    
    private func setupSeparatorLabel() {
//        view.addSubview(separatorLabel)
//        
//        separatorLabel.snp.makeConstraints({
//            $0.top.equalTo(loginView.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//        })
    }
    
    private func setupLoginView() {
        view.addSubview(loginView)
        loginView.delegate = self
        loginView.snp.makeConstraints {
            $0.centerY.equalToSuperview().inset(35)
            $0.height.equalTo(250)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
}



extension RegistrationViewController: RegistrationViewInput {
    
    func setupInitialState() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        navigationController?.setNavigationBarHidden(true, animated: false)
       // setupLabel()
        setupLoginView()
        setupSeparatorLabel()
        setupSubscriptions()
    }
    
    func showTextFieldForCode() {
        loginView.animateCodeTextFieldIn()
    }
    
    func showPhoneError() {
        print("So close")
    }
    
    
}

extension RegistrationViewController: LoginViewDelegate {
    
    func didTapLoginButton(email: String, password: String) {
        output.engageAuthorizathion(withEmail: email, andPassword: password)
    }
}
