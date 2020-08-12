//
//  CreateAdCreateAdViewController.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CreateAdViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var output: CreateAdViewOutput!
    
    private let addPhotosCollection: AddPhotosCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = AddPhotosCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let imagePickerController: UIImagePickerController = {
        let imagePC = UIImagePickerController()
        return imagePC
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создать новое объявление"
        label.font = .systemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()
    
    private let customTextField = AdsTextField()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func createSubscriptions() {
        
        customTextField.textFieldDidType
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        
        addPhotosCollection.didSelectItem.map { (indexPath) -> Int in
                return indexPath.row
        }.subscribe(onNext: { [unowned self] index in
            self.output.didSelectRow(withIndex: index)
        }).disposed(by: disposeBag)
        
    }
    
    private func setupLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        })
        
        //        view.addSubview(customTextField)
        //
        //        customTextField.snp.makeConstraints({
        //            $0.width.equalToSuperview().multipliedBy(0.8)
        //            $0.height.equalTo(90)
        //            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        //            $0.centerX.equalToSuperview()
        //        })
    }
    
    private func setupCollectionView() {
        addPhotosCollection.register(AddPhotosCollectionViewCell.self)
        view.addSubview(addPhotosCollection)
        addPhotosCollection.snp.makeConstraints({
            $0.width.equalToSuperview()
            $0.height.equalTo(180)
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        })
        
    }
}

// MARK: - CreateAdViewInput
extension CreateAdViewController: CreateAdViewInput {
    
    func setupInitialState() {
        setupLabel()
        createSubscriptions()
        setupCollectionView()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        view.backgroundColor = R.color.appColors.background()
    }
    
    func openImageController() {
        present(imagePickerController, animated: true, completion: nil)
    }
}


// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension CreateAdViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            print("edited image")
        } else if let originalImage = info[.originalImage] {
            print("orginal image")
        }
    }
}


