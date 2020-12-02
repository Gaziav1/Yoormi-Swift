//
//  ImageAndNameImageAndNameViewController.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageAndNameViewController: UIViewController, ImageAndNameViewInput {

    var output: ImageAndNameViewOutput!
    
    private let disposeBag = DisposeBag()

    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.snp.makeConstraints {
            $0.size.equalTo(LayoutConstants.AddPhotoButton.size)
        }
   
        button.backgroundColor = .systemGray6
        button.setImage(R.image.icons.camera()?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let addPhotoLabel: UILabel = {
        let label = UILabel("Добавьте фото профиля (необязательно)")
        label.textColor = .systemGray4
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let nameTextField: RegistrationTextField = {
       let tf = RegistrationTextField(text: "Ваше имя")
        tf.textField.textContentType = .name
        tf.textField.keyboardType = .alphabet
       return tf
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray4
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.systemGray6, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let popUpPhotoView: PopUpView = PopUpView()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: Layout setup
    private func setupButton() {
        view.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        })
    
        addPhotoButton.layer.cornerRadius = LayoutConstants.AddPhotoButton.size / 2
        
        addPhotoButton.rx.controlEvent(.touchUpInside).bind {
            self.popUpPhotoView.fadeIn()
        }.disposed(by: disposeBag)
    }
    
    private func setupAddPhotoLabel() {
        view.addSubview(addPhotoLabel)
        addPhotoLabel.snp.makeConstraints({
            $0.bottom.equalTo(addPhotoButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints({
            $0.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
    }
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints({
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        })
    }
    
    private func setupPopUpView() {
        view.addSubview(popUpPhotoView)
        
        popUpPhotoView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    // MARK: ImageAndNameViewInput
    func setupInitialState() {
        view.backgroundColor = .white
        setupButton()
       // setupAddPhotoLabel()
        setupNameTextField()
        setupContinueButton()
        setupPopUpView()
    }
}



private enum LayoutConstants {
    enum AddPhotoButton {
        static let size: CGFloat = 150
    }
}
