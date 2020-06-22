//
//  RegistrationRegistrationViewController.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
import Firebase
import SnapKit

class RegistrationViewController: UIViewController, RegistrationViewInput {
    
   
    
    private let loginView = LoginView()
    


    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        return button
    }()
    
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
    
    
    // MARK: RegistrationViewInput
    func setupInitialState() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        navigationController?.setNavigationBarHidden(true, animated: false)
       // setupLabel()
        setupLoginView()
        setupSeparatorLabel()
        setupSkipButton()
    }
    

    private func setupSeparatorLabel() {
        view.addSubview(separatorLabel)
        
        separatorLabel.snp.makeConstraints({
            $0.top.equalTo(loginView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        })
    }
    
  
    
    private func setupSkipButton() {
        view.addSubview(skipButton)
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.trailing.equalTo(loginView)
            $0.height.equalTo(40)
        }
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


extension RegistrationViewController: LoginViewDelegate {
    
    func didTapLoginButton(email: String, password: String) {
        output.engageAuthorizathion(withEmail: email, andPassword: password)
    }
}
