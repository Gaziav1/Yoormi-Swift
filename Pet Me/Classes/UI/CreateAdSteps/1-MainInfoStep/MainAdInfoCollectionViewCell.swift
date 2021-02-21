//
//  CreateAdStepsCollectionView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 17.02.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit

enum CreateAdStep: Int, CaseIterable {
    case mainInfo
    case photoAndDescription
    case mapAndAdress
    case final
}


class MainAdInfoCollectionViewCell: UICollectionViewCell {
    
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
    
    private lazy var stackView = UIStackView(arrangedSubviews: [dogChoiceControl, catChoiceControl])
    
    //выбор пола
    //имя
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupUI()
        setupAnimalSubtypeGroup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupAnimalSubtypeGroup() {
        addSubview(animalSubTypeCollection)
        animalSubTypeCollection.delegate = self
        animalSubTypeCollection.dataSource = self
        
        scrollView.addSubview(animalSubTypeLabel)
        scrollView.addSubview(animalSubTypeCollection)
        
        animalSubTypeLabel.snp.makeConstraints({
            $0.leading.equalTo(containerLayoutGuide).inset(10)
            $0.top.equalTo(stackView.snp.bottom).offset(20)
        })
        
        animalSubTypeCollection.snp.makeConstraints({
            $0.leading.trailing.equalTo(containerLayoutGuide)
            $0.top.equalTo(animalSubTypeLabel.snp.bottom).offset(10)
            $0.height.equalTo(200)
        })
    }
    
    func setup(fromStep step: CreateAdStep) {
        switch step {
        case .mainInfo:
            setupUI()
        default:
            setupUI()
        }
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
        scrollView.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.snp.makeConstraints({
            $0.top.equalTo(containerLayoutGuide)
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
