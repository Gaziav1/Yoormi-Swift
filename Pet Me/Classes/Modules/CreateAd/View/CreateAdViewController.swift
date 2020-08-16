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
        cv.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let infoCollectionView: CreateAdInfoCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = CreateAdInfoCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return cv
    }()
    
    private let imagePickerController: CustomImagePicker = {
        let imagePC = CustomImagePicker()
        imagePC.imageLimit = 5
        return imagePC
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создать новое объявление"
        label.font = .systemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    private func createSubscriptions() {
        
        imagePickerController.choosenImagesObservable.subscribe(onNext: { [unowned self] images in
            self.addPhotosCollection.setupPhotos(photos: images)
            }).disposed(by: disposeBag)
        
//        customTextField.textFieldDidType
//            .subscribe(onNext: {
//                print($0)
//            }).disposed(by: disposeBag)
        
        
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
        
        
    }
    
    private func setupTextFields() {
        view.addSubview(infoCollectionView)
        
        infoCollectionView.snp.makeConstraints({
            $0.top.equalTo(addPhotosCollection.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        })
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
        setupTextFields()
        view.backgroundColor = R.color.appColors.background()
    }
    
    func openImageController() {
        present(imagePickerController, animated: true, completion: nil)
    }
}



