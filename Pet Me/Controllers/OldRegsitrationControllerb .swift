//
//  RegistrationViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 27.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class OldRegsitrationControllerb: UIViewController {
    
    fileprivate let registrationViewModel = RegistrationViewModel()
    
    fileprivate let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выберите фотку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    fileprivate let fullNameTextField: UITextField = {
        let tf = CustomTextField()
        tf.placeholder = "Введите имя"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    fileprivate let emailTextField: UITextField = {
        let tf = CustomTextField()
        tf.placeholder = "Введите email"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let tf = CustomTextField()
        tf.placeholder = "Введите пароль"
        tf.backgroundColor = .white
        //tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    fileprivate let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray
        button.setTitle("Зарегистрироваться", for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        button.setTitleColor(.lightGray, for: .disabled)
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [fullNameTextField, emailTextField, passwordTextField, registerButton])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    fileprivate let registrationHUD = JGProgressHUD(style: .dark)
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate var activeTextField: UITextField?
    fileprivate let scrollView = UIScrollView()
    fileprivate lazy var overallStackView = UIStackView(arrangedSubviews: [selectPhotoButton, verticalStackView])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupScrollView()
        setDelegates()
        setupLoginButton()
        setupStackView()
        setupNotificationsObserver()
        bindToRegistrationViewModel()
        navigationController?.isNavigationBarHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overallStackView.axis = .horizontal
        } else {
            overallStackView.axis = .vertical
        }
    }
    
    fileprivate func setupLoginButton() {
        scrollView.addSubview(loginButton)
        loginButton.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        scrollView.contentSize = view.frame.size
    }
    
    fileprivate func setupNotificationsObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func bindToRegistrationViewModel() {
        registrationViewModel.bindableIsFormValid.bind(observer: { [unowned self] isValid in
            guard let isFormValid = isValid else { return }
            self.registerButton.isEnabled = isFormValid ? true : false
            self.registerButton.backgroundColor = isFormValid ? .appLightGreen : .systemGray
        })
        
        registrationViewModel.bindableImage.bind(observer: { [unowned self] image in
            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        })
        
        registrationViewModel.bindableIsRegistering.bind { [unowned self] (isRegistering) in
            if isRegistering == true {
                self.registrationHUD.textLabel.text = "Register"
                self.registrationHUD.show(in: self.view)
            } else {
                self.registrationHUD.dismiss()
            }
        }
    }
    
    @objc fileprivate func handleLogin() {
        let loginController = LoginController()
        loginController.view.backgroundColor = .yellow
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    @objc fileprivate func keyboardWillHide() {
        self.scrollView.contentInset.bottom = 0
        self.scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        switch textField {
        case fullNameTextField:
            registrationViewModel.fullName = textField.text
        case emailTextField:
            registrationViewModel.email = textField.text
        case passwordTextField:
            registrationViewModel.password = textField.text
        default:
            ()
        }
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value =  notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardValue = value.cgRectValue
        scrollView.contentInset.bottom = keyboardValue.height
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardValue.height
        
        guard let activeTextField = activeTextField else { return }
        let visibleRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
        
        scrollView.scrollRectToVisible(visibleRect, animated: true)
    }
    
    @objc fileprivate func registerUser() {
        dismissKeyboard()

        registrationViewModel.performRegistration { [unowned self] (error) in
            guard error == nil else {
                self.showHUDWithError(error: error!)
                return
            }
            let homeController = CardsViewController()
            homeController.modalPresentationStyle = .fullScreen
            self.present(homeController, animated: true)
        }
    }
    
    @objc fileprivate func handleSelectPhoto() {
        dismissKeyboard()
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    fileprivate func showHUDWithError(error: Error) {
        registrationHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        
        hud.dismiss(afterDelay: 3, animated: true)
    }
    
    fileprivate func setupStackView() {
        
        scrollView.addSubview(overallStackView)
        overallStackView.axis = .vertical
        
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overallStackView.spacing = 8
        overallStackView.snp.makeConstraints({
            $0.leading.trailing.equalTo(view).inset(50)
            $0.centerY.equalToSuperview()
        })
    }
    
    fileprivate func setupGradient() {
        
        let topColor = UIColor.appLightGreen.cgColor
        let bottomColor = UIColor.appDarkGreen.cgColor
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0, 1]
        
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setDelegates() {
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: - UITextFieldDelegate
extension OldRegsitrationControllerb: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension OldRegsitrationControllerb: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registrationViewModel.bindableImage.value = image
        dismiss(animated: true)
    }
}


