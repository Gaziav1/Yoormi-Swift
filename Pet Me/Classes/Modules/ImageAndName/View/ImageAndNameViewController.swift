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
    
    private var choosenPhoto: UIImage?
    
    private let disposeBag = DisposeBag()
    
    private let scrollView = UIScrollView()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.snp.makeConstraints {
            $0.size.equalTo(LayoutConstants.AddPhotoButton.size)
        }
        button.backgroundColor = .systemGray6
        button.setImage(R.image.icons.camera()?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    
    private let scrollViewContainer = UIView()
    
    private let addPhotoLabel: UILabel = {
        let label = UILabel.localizedLabel(.addProfilePhotoLabel)
        label.textColor = .systemGray4
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let nameTextField: RegistrationTextField = {
        let tf = RegistrationTextField(text: .userNameTextField)
        tf.textField.textContentType = .name
        tf.textField.keyboardType = .alphabet
        return tf
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray4
        button.setLocalizedTitle(.continueButtonTitle)
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
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    
        scrollView.addSubview(scrollViewContainer)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollViewContainer.backgroundColor = .clear
        
        scrollViewContainer.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.size.equalToSuperview()
        })
    }
    
    private func setupButton() {
        scrollViewContainer.addSubview(addPhotoButton)
        addPhotoButton.snp.makeConstraints({
            $0.centerX.equalTo(scrollViewContainer)
            $0.centerY.equalTo(scrollViewContainer).offset(-30)
        })
        
        addPhotoButton.layer.cornerRadius = LayoutConstants.AddPhotoButton.size / 2
        
        addPhotoButton.rx.controlEvent(.touchUpInside).bind {
            self.view.endEditing(false)
            self.popUpPhotoView.fadeIn()
        }.disposed(by: disposeBag)
    }
    
    private func setupAddPhotoLabel() {
        scrollViewContainer.addSubview(addPhotoLabel)
        addPhotoLabel.snp.makeConstraints({
            $0.bottom.equalTo(addPhotoButton.snp.top).offset(-20)
            $0.leading.trailing.equalTo(scrollViewContainer).inset(10)
        })
    }
    
    private func setupNameTextField() {
        scrollViewContainer.addSubview(nameTextField)
        nameTextField.textField.delegate = self
        nameTextField.snp.makeConstraints({
            $0.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(scrollViewContainer).inset(10)
        })
    }
    
    private func setupContinueButton() {
        scrollViewContainer.addSubview(continueButton)
        
        continueButton.snp.makeConstraints({
            $0.bottom.equalTo(scrollViewContainer).inset(15)
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(scrollViewContainer).inset(20)
        })
        
        continueButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {
            let data = self.choosenPhoto?.jpegData(compressionQuality: 1.0)
            guard let text = self.nameTextField.textField.text else { return }
            self.output.saveProfile(withImageData: data, name: text)
        }).disposed(by: disposeBag)
    }
    
    private func setupPopUpView() {
        view.addSubview(popUpPhotoView)
        
        popUpPhotoView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    
    private func setupSubcriptions() {
        popUpPhotoView.popViewItemsTappingObservable.subscribe(onNext: { [weak self] tappedItemType in
            self?.showImagePicker(fromType: tappedItemType)
        }).disposed(by: disposeBag)
        
        nameTextField.isValidSubject.subscribe(onNext: { [weak self] isValidText in
            guard let self = self else { return }
            self.continueButton.backgroundColor = isValidText ? .systemBlue : .systemGray4
        }).disposed(by: disposeBag)
        
        NotificationCenter.default.keyboardHeight().subscribe(onNext: { element in
            self.scrollView.setContentOffset(.init(x: 0, y: element == 0 ? 0 : element + self.continueButton.frame.height), animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func showImagePicker(fromType type: PopViewItemType) {
        switch type {
        case .takePhoto:
            imagePickerController.sourceType = .camera
        case .choosePhoto:
            imagePickerController.sourceType = .photoLibrary
        case .noPhoto:
            addPhotoButton.setImage(R.image.icons.camera()?.withRenderingMode(.alwaysOriginal), for: .normal)
            return
        }
        
        present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - ImageAndNameViewInput
extension ImageAndNameViewController: ImageAndNameViewInput {
    func showError(head: String, body: String) {
        let errorController = UIAlertController.prepareErrorController(header: head, body: body)
        present(errorController, animated: true, completion: nil)
    }
    
    
    func setupInitialState() {
        imagePickerController.delegate = self
        view.backgroundColor = .white
        setupScrollView()
        setupButton()
         //setupAddPhotoLabel()
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
            choosenPhoto = nil
            return
        }
        
        choosenPhoto = photo
        addPhotoButton.setImage(photo.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}

extension ImageAndNameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        //TODO: Засунь это в кастомный вью класс который содержит текстфилд
        
        
        nameTextField.validate(text: text)
                
        return true
    }
    
    
}


private enum LayoutConstants {
    enum AddPhotoButton {
        static let size: CGFloat = 150
    }
}
