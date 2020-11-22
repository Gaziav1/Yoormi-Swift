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
    
    private let scrollView = UIScrollView()
    
    private let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .clear
        return cv
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
        endEditing()
        output.openSideMenu()
    }
    
    //MARK: - Animations
    
    private func animateLabelTextChange() {
        let animationDuration: TimeInterval = 0.9
        let firstAndSecondAnimationRelativeDuration = 0.5
     
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: { [weak self] in
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: firstAndSecondAnimationRelativeDuration, animations: {
                self?.labelHelper.transform = CGAffineTransform(translationX: 0, y: -25)
                self?.labelHelper.alpha = 0
            })
            
            delay(seconds: Double(animationDuration * firstAndSecondAnimationRelativeDuration)) { [weak self] in
                self?.labelHelper.text = "Пожалуйста, введите код из СМС"
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: firstAndSecondAnimationRelativeDuration, animations: { [weak self] in
                self?.labelHelper.transform = .identity
                self?.labelHelper.alpha = 1
            })
            
        }, completion: nil)
    }
    
    //MARK: - Layout setup
    
    private func setupSubscriptions() {
        loginView.phoneTextFieldObservable.subscribe(onNext: { [weak self] data in
            self?.output.handlePhoneAuth(withData: data)
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.keyboardHeight().subscribe(onNext: { [weak self] element in
            guard let self = self else { return }
            self.scrollView.scrollRectToVisible(element > 0 ? self.loginView.frame : self.authImage.frame, animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func setupSeparatorLabel() {
//        containerView.addSubview(separatorLabel)
//        
//        separatorLabel.snp.makeConstraints({
//            $0.top.equalTo(loginView.snp.bottom).offset(20)
//            $0.centerX.equalToSuperview()
//        })
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints({ $0.edges.equalToSuperview()
            $0.size.equalToSuperview()
        })

        setupSeparatorLabel()
        setupImageView()
        setupLabel()
        setupLoginView()
    }
    
    private func setupLoginView() {
        containerView.addSubview(loginView)
        loginView.snp.makeConstraints {
            $0.top.equalTo(labelHelper.snp.bottom).offset(40)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupLabel() {
        containerView.addSubview(labelHelper)
        labelHelper.snp.makeConstraints({
            $0.top.equalTo(authImage.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(5)
        })
    }
    
    private func setupImageView() {
        containerView.addSubview(authImage)
        
        authImage.snp.makeConstraints({
            $0.top.leading.trailing.equalTo(containerView.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(150)
        })
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
        setupUI()
        setupSubscriptions()
    }
    
    func showTextFieldForCode() {
        let image = R.image.icons.sms()
        
        UIView.transition(with: authImage, duration: 1, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.authImage.image = image
        }, completion: nil)
        
        animateLabelTextChange()
        loginView.animateCodeTextField(hide: false)
    }
    
    func showPhoneError() {
        print("So close")
    }
}
