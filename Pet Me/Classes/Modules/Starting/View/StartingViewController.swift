//
//  StartingStartingViewController.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
import Lottie

class StartingViewController: UIViewController, StartingViewInput {
    
    var output: StartingViewOutput!
    
    private let catAnimationView = AnimationView(name: "CatWaiting")
    
    private let appleSignInButton = ASAuthorizationAppleIDButton(type: .continue, style: .black)
    private let googleSignInButton: CustomSignInButton = {
        let button = CustomSignInButton(text: "Continue with Google")
        return button
    }()
    
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.text = "или"
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let signInWithEmail: CustomSignInButton = {
        let button = CustomSignInButton(text: "Sign in with Email", icon: R.image.icons.email())
        button.backgroundColor = R.color.appColors.controlSelection()
        button.titleLabel.textColor = .white
        button.iconPosition = .right
        return button
    }()
    
    private let titleLabel: UILabel = {
        let string = NSMutableAttributedString()
        
        let title = NSAttributedString(string: "Добро пожаловать,\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.label,
                                                                                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 27)])
        string.append(title)
        
        let subTitle = NSAttributedString(string: "Войдите, чтобы продолжить", attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23)])
        
        string.append(subTitle)
        
        let label = UILabel()
        label.attributedText = string
        label.numberOfLines = 0
        label.setLineSpacing(lineSpacing: 5)
        return label
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    // MARK: StartingViewInput
    func setupInitialState() {
        setupLabel()
        setupSignInButtons()
        setupAnimationView()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupAnimationView() {
        view.addSubview(catAnimationView)
        catAnimationView.snp.makeConstraints({
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(appleSignInButton.snp.top).offset(25)
        })
        catAnimationView.loopMode = .loop
        catAnimationView.animationSpeed = 0.5
        catAnimationView.play()
    }
    
    private func setupLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func setupSignInButtons() {
        
        
        let stackView = UIStackView(arrangedSubviews: [appleSignInButton, googleSignInButton, separatorLabel, signInWithEmail])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        appleSignInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(appleButtonTapped)))
        googleSignInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInGoogle)))
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        stackView.snp.makeConstraints({
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(205)
        })
        
        
    }
    
    @objc private func appleButtonTapped() {
        guard let window = view.window else { return }
        output.appleSignInTapped(presentationAnchor: window)
    }
    
    
    @objc private func signInGoogle() {
        output.googleSignInTapped()
    }
    
    @objc private func signInWithMail() {
        
    }
    
}

