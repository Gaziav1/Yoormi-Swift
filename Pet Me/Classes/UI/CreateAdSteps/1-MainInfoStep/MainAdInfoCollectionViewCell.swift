//
//  CreateAdStepsCollectionView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 17.02.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

enum CreateAdStep: Int, CaseIterable {
    case mainInfo
    case photoAndDescription
    case mapAndAdress
    case final
}


class MainAdInfoCollectionViewCell: UICollectionViewCell {
    
    private let disposeBag = DisposeBag()
    private let animalTypeSubject = PublishSubject<AnimalTypes>()
    
    var animalTypeChoiceObservable: Observable<AnimalTypes> {
        return animalTypeSubject.asObservable()
    }
    
    private let dummyAnimalSubTypeInfo = ["Хаски", "Бульдог", "Неизвестный", "Без названия", "Джон Шепард"]
    private let scrollView = UIScrollView()
    private let containerLayoutGuide = UILayoutGuide()
    
    private let dogChoiceControl = AnimalChoosingControl(animalType: .dog)
    private let catChoiceControl = AnimalChoosingControl(animalType: .cat)
    private let animalSubTypeCollection: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        fl.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: fl)
        cv.register(AdSubTypeCollectionViewCell.self)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let animalSubTypeLabel = UILabel.localizedLabel(.animalSubtypeLabel)
    private let animalTypeLabel = UILabel.localizedLabel(.animalTypeLabel)
    
    private lazy var animalChoiceViewsStack = UIStackView(arrangedSubviews: [dogChoiceControl, catChoiceControl])
    
    //выбор пола
    //имя
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubscriptions()
    }
    
    override func layoutSubviews() {
        setupScrollView()
        setupUI()
        setupAnimalSubtypeGroup()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupSubscriptions() {
        [dogChoiceControl, catChoiceControl].forEach({
            $0.choosenAnimalType.subscribe(onNext: { [weak self] element in
                self?.animalTypeSubject.onNext(element)
            }).disposed(by: disposeBag)
        })
    }
    
    private func setupAnimalSubtypeGroup() {
        addSubview(animalSubTypeCollection)
        animalSubTypeCollection.delegate = self
        animalSubTypeCollection.dataSource = self
        
        scrollView.addSubview(animalSubTypeLabel)
        scrollView.addSubview(animalSubTypeCollection)
        
        animalSubTypeLabel.snp.makeConstraints({
            $0.leading.equalTo(containerLayoutGuide).inset(10)
            $0.top.equalTo(animalChoiceViewsStack.snp.bottom).offset(20)
        })
        
        animalSubTypeCollection.snp.makeConstraints({
            $0.leading.trailing.equalTo(containerLayoutGuide)
            $0.top.equalTo(animalSubTypeLabel.snp.bottom).offset(10)
            $0.height.equalTo(200)
        })
    }
    
    
    private func setupScrollView() {
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        })
        scrollView.addLayoutGuide(containerLayoutGuide)
       
        containerLayoutGuide.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    private func setupUI() {
        scrollView.addSubview(animalChoiceViewsStack)
        animalChoiceViewsStack.distribution = .fillEqually
        animalChoiceViewsStack.spacing = 5
        animalChoiceViewsStack.snp.makeConstraints({
            $0.top.equalTo(containerLayoutGuide).offset(dogChoiceControl.intrinsicContentSize.height - 5)
            $0.centerX.equalTo(containerLayoutGuide)
        })
    }
}


//MARK: - UICollectionViewDelegate & DataSource
extension MainAdInfoCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyAnimalSubTypeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as AdSubTypeCollectionViewCell
        cell.animalTypeLabel.text = dummyAnimalSubTypeInfo[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainAdInfoCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = dummyAnimalSubTypeInfo[indexPath.item].size(withAttributes: nil).width
        return .init(width: width + 22, height: 35)
    }
    
}
