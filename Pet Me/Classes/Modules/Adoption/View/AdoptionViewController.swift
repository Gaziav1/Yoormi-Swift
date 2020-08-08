//
//  AdoptionAdoptionViewController.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import RxSwift

class AdoptionViewController: ControllerWithSideMenu {
    
    var output: AdoptionViewOutput!
    private let disposeBag = DisposeBag()
    

    private let dogChoosingView = AnimalChoosingControl(title: "Собаки", image: R.image.icons.dogChoice())
    private let cat = AnimalChoosingControl(title: "Кошки", image: R.image.icons.catChoice())
   
    private let animalsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(AnimalsForAdoptionCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
    }
    
    override func sideMenuAction() {
        output.presentSideMenu()
    }
    
    
    //MARK: - LayoutSetup
    
    private func setupAnimalChoosingViews() {
        
        let stackView = UIStackView(arrangedSubviews: [dogChoosingView, cat])
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(90)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(15)
        })
        
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        [dogChoosingView, cat].forEach { $0.choosenAnimalType.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)}
        
    }
    
    private func setupCollectionView() {
        animalsCollectionView.delegate = self
        animalsCollectionView.dataSource = self
        view.addSubview(animalsCollectionView)
        animalsCollectionView.backgroundColor = .clear
        
        animalsCollectionView.snp.makeConstraints( {
            $0.top.equalTo(dogChoosingView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        })
    }
}

// MARK: - AdoptionViewInput
extension AdoptionViewController: AdoptionViewInput {
    
    func setupInitialState() {
        view.backgroundColor = .white
        setupAnimalChoosingViews()
        setupCollectionView()
    }
}

// MARK: - UICollectionView
extension AdoptionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnimalsForAdoptionCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.animalImage.image = indexPath.row % 2 == 0 ? R.image.images.doggoTest2() : R.image.images.doggoTest()
        cell.genderImage.image = indexPath.row % 2 == 0 ? R.image.icons.girl() : R.image.icons.boy()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 170, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(atIndex: indexPath.row)
    }
    
}
