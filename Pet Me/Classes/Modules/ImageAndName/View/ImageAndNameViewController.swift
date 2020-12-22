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

class ImageAndNameViewController: UIViewController {
    
    var output: ImageAndNameViewOutput!
    
    private let imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = true
        return ip
    }()
    
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
    
    private let popUpPhotoView = PopUpView()
    
    
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
    
    
    private func setupSubcriptions() {
        popUpPhotoView.popViewItemsTappingObservable.subscribe(onNext: { [weak self] tappedItemType in
            self?.showImagePicker(fromType: tappedItemType)
        }).disposed(by: disposeBag)
    }
    
    private func showImagePicker(fromType type: PopViewItemType) {
        switch type {
        case .takePhoto:
            imagePickerController.sourceType = .camera
        case .choosePhoto:
            imagePickerController.sourceType = .photoLibrary
        case .noPhoto:
            addPhotoButton.setImage(R.image.icons.camera(), for: .normal)
            return
        }
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - ImageAndNameViewInput
extension ImageAndNameViewController: ImageAndNameViewInput {
    
    func setupInitialState() {
        imagePickerController.delegate = self
        view.backgroundColor = .white
        setupButton()
        // setupAddPhotoLabel()
        setupNameTextField()
        setupContinueButton()
        setupPopUpView()
        setupSubcriptions()
    }
}


// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ImageAndNameViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let photo = info[.originalImage] as? UIImage else {
            print("NO IMAGE")
            return
        }
        
        addPhotoButton.setImage(photo.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.imageView?.layer.cornerRadius = LayoutConstants.AddPhotoButton.size / 2
    }
}


private enum LayoutConstants {
    enum AddPhotoButton {
        static let size: CGFloat = 150
    }
}
