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
    
    
    //MARK: -Private properties
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
    
    //MARK: - Viper dependencies
    
    var output: RegistrationViewOutput!
    
    // MARK: - Life cycle
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
    
    private func showCodeTextField() {
        let image = R.image.icons.sms()
        
        UIView.transition(with: authImage, duration: 1, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.authImage.image = image
        }, completion: nil)
        
        animateLabelTextChange()
        loginView.animateCodeTextField(hide: false)
    }
    
    
    //MARK: - RX Subscriptions
    private func setupSubscriptions() {
        loginView.phoneTextFieldObservable.subscribe(onNext: { [weak self] phone in
            self?.output.handlePhoneAuth(withPhone: phone)
        }).disposed(by: disposeBag)
        
        loginView.codeTextFieldObservable.subscribe(onNext: { [weak self] code in
            self?.output.confirm(code: code)
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.keyboardHeight().subscribe(onNext: { [weak self] keyboardHeight in
            guard let self = self else { return }
            self.scrollView.contentInset.bottom = keyboardHeight
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Layout setup
    private func setupUI() {
        cofigureMainView()
        setupScrollView()
        setupContainerView()
        setupLoginView()
        setupLabel()
        setupImageView()
    }
    
    private func cofigureMainView() {
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupContainerView() {
        containerView.backgroundColor = .clear
        
        let scrollViewLayout = scrollView.contentLayoutGuide
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints({
            $0.edges.equalTo(scrollViewLayout)
            $0.size.equalToSuperview()
        })
    }
    
    private func setupLoginView() {
        containerView.addSubview(loginView)
        loginView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupLabel() {
        containerView.addSubview(labelHelper)
        labelHelper.adjustsFontSizeToFitWidth = true
        labelHelper.snp.makeConstraints({
            $0.bottom.equalTo(loginView.snp.top).offset(-25)
            $0.leading.trailing.equalToSuperview().inset(5)
        })
    }
    
    private func setupImageView() {
        containerView.addSubview(authImage)
        
        authImage.snp.makeConstraints({
            $0.bottom.equalTo(labelHelper.snp.top).offset(-10)
            $0.top.equalTo(containerView).inset(5)
            $0.leading.trailing.equalToSuperview().inset(40)
        })
        
        authImage.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        authImage.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    }
    
    
    //MARK: - Objc Actions
    @objc private func endEditing() {
        view.endEditing(true)
    }
}



//MARK: - RegistrationViewInput
extension RegistrationViewController: RegistrationViewInput {
    
    func setupInitialState() {
        setupUI()
        setupSubscriptions()
    }
    
    func showTextFieldForCode() {
        showCodeTextField()
    }
    
    func showPhoneError() {
        print("So close")
    }
}
