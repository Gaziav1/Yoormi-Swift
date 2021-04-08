//
//  PhotosAndDescriptionCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 06.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

struct SecondStepCellInfo {
    let description: String
    let images: [UIImage]
}

class PhotosAndDescriptionCollectionViewCell: UICollectionViewCell {
    
    
    private var choosenPhotos: [UIImage]? {
        didSet {
            changeButtonColor()
        }
    }
    
    private var typedDescription: String? {
        didSet {
            changeButtonColor()
        }
    }
    
    private let buttonTapSubject = PublishSubject<SecondStepCellInfo>()
    
    var didSelectAddPhoto: Observable<IndexPath> {
        return addPhotosCollection.didSelectItem.asObservable()
    }
    
    var didSelectButtonObervable: Observable<SecondStepCellInfo> {
        return buttonTapSubject.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    private let addPhotosTitle = UILabel.localizedLabel(.addPetPhotos)
    private let addPhotosCollection: AddPhotosCollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        let cv = AddPhotosCollectionView(frame: .zero, collectionViewLayout: fl)
        return cv
    }()
    
    private let descriptionLabel = UILabel.localizedLabel(.addPetDescription)
    private let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.returnKeyType = .done
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemGray5.cgColor
        tv.layer.cornerRadius = 10
        tv.clipsToBounds = true
        tv.textContainerInset = .init(top: 10, left: 5, bottom: 0, right: 5)
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton.createDisabledButton(withTitle: .next)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupCollectionView()
        setupDescriptionTextView()
        setupDismissKeyboardGesture()
        setupNextButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(_ images: [UIImage]) {
        addPhotosCollection.setupPhotos(photos: images)
        self.choosenPhotos = images
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        tapGesture.rx.event.subscribe(onNext: { _ in
            self.descriptionTextView.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    private func setupNextButton() {
        addSubview(nextButton)
        
        nextButton.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        })
        
        nextButton.rx.tap.subscribe(onNext: { _ in
            guard let desc = self.typedDescription, let photos = self.choosenPhotos else { return }
            let secondStepCellInfo = SecondStepCellInfo(description: desc, images: photos)
            self.buttonTapSubject.onNext(secondStepCellInfo)
        }).disposed(by: disposeBag)
    }
    
    
    private func changeButtonColor() {
        let shouldEnableButton = choosenPhotos != nil && typedDescription != nil
        nextButton.isEnabled = shouldEnableButton
        nextButton.backgroundColor = shouldEnableButton ? .appLightGreen : .systemGray4
    }
    
    private func setupCollectionView() {
        
        addPhotosTitle.textColor = .systemGray2
        
        addSubview(addPhotosTitle)
        addPhotosTitle.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        })
        
        addSubview(addPhotosCollection)
        addPhotosCollection.snp.makeConstraints({
            $0.top.equalTo(addPhotosTitle.snp.bottom).offset(10)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(175)
        })
    }
    
    private func setupDescriptionTextView() {
        addSubview(descriptionLabel)
        addSubview(descriptionTextView)
        
        descriptionLabel.textColor = .systemGray2
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(addPhotosCollection.snp.bottom).offset(30)
            $0.leading.equalTo(addPhotosTitle)
        })
        
        descriptionTextView.snp.makeConstraints({
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(175)
        })
        
        descriptionTextView.rx.text.subscribe(onNext: { text in
            guard let text = text else { return }
            self.checkForDoneButtonPressed(text)
        }).disposed(by: disposeBag)
    }
    
    private func checkForDoneButtonPressed(_ text: String) {
        guard !text.isEmpty else { return }
        let lastTwoChars = text.suffix(1)
        
        if lastTwoChars == "\n" {
            self.descriptionTextView.text.removeLast(1)
            self.descriptionTextView.resignFirstResponder()
        }
        
        self.typedDescription = descriptionTextView.text
    }
}

