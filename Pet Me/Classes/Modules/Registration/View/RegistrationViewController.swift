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
    
    private let labelHelper: UILabel = {
        let label = UILabel()
        label.text = "Введите ваш номер для авторизации"
        label.textColor = .tertiaryLabel
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let authImage: UIImageView = {
        let iv = UIImageView(image: R.image.icons.password())
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
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
    
    override func sideMenuAction() {
        output.openSideMenu()
    }
    
    //MARK: - Animations
    
    private func animateLabelTextChange() {
        let originalCenter = labelHelper.center
        let animationDuration: TimeInterval = 0.9
        let firstAndSecondAnimationRelativeDuration = 0.5
        
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: { [weak self] in
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: firstAndSecondAnimationRelativeDuration, animations: {
                self?.labelHelper.transform = CGAffineTransform(translationX: 0, y: -25)
                self?.labelHelper.alpha = 0
            })
            
            delay(seconds: Double(animationDuration * firstAndSecondAnimationRelativeDuration)) { [weak self] in
                self?.labelHelper.text = "Для подтверждения вашего номера, пожалуйста, введите код из СМС"
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: firstAndSecondAnimationRelativeDuration, animations: { [weak self] in
                self?.labelHelper.transform = .identity
                self?.labelHelper.alpha = 1
            })
            
        }, completion: nil)
    }
    
    //MARK: - Layout setup
    
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
            $0.top.equalTo(labelHelper.snp.bottom).offset(40)
            $0.height.equalTo(250)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupLabel() {
        view.addSubview(labelHelper)
        labelHelper.snp.makeConstraints({
            $0.top.equalTo(authImage.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
    }
    
    private func setupImageView() {
        view.addSubview(authImage)
        
        authImage.snp.makeConstraints({
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(150)
        })
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "Авторизация"
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
}



extension RegistrationViewController: RegistrationViewInput {
    
    func setupInitialState() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
       // setupLabel()
        setupSeparatorLabel()
        setupSubscriptions()
        setupImageView()
        setupLabel()
        setupLoginView()
    }
    
    func showTextFieldForCode() {
        let image = R.image.icons.sms()
        
        UIView.transition(with: authImage, duration: 1, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.authImage.image = image
        }, completion: nil)
        
        animateLabelTextChange()
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
