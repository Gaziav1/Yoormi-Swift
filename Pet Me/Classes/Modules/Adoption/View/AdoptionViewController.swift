//
//  AdoptionAdoptionViewController.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import RxSwift

class AdoptionViewController: ParentViewController {
    
    var output: AdoptionViewOutput!
    private let disposeBag = DisposeBag()
    

    private let dogChoosingView = AnimalChoosingControl(animalType: .dog)
    private let cat = AnimalChoosingControl(animalType: .cat)
   
    private let animalsCollectionView: UICollectionView = {
        let cvCustomLayout = AdoptionCustomCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: cvCustomLayout)
        collectionView.register(AnimalsForAdoptionCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        showIndicator(withConfiguration: .loadingCat)
    }
    
    
    //MARK: - LayoutSetup
    
    private func setupAnimalChoosingViews() {
        
        let stackView = UIStackView(arrangedSubviews: [dogChoosingView, cat])
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
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
        
        if let customLayout = animalsCollectionView.collectionViewLayout as? AdoptionCustomCollectionViewLayout {
            customLayout.delegate = self
        }
    }
}

// MARK: - AdoptionViewInput
extension AdoptionViewController: AdoptionViewInput {
    func showAds(_ ads: [AnimalAd]) {
        hideIndication(true)
    }
    
    func showError(_ title: String, _ message: String) {
        hideIndication(true)
    }
    
    
    func setupInitialState() {
        view.backgroundColor = .white
        setupAnimalChoosingViews()
        setupCollectionView()
        
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension AdoptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnimalsForAdoptionCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.animalImage.image = indexPath.row % 2 == 0 ? R.image.images.doggoTest2() : R.image.images.doggoTest()
        cell.genderImage.image = indexPath.row % 2 == 0 ? R.image.icons.girl() : R.image.icons.boy()
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(atIndex: indexPath.row)
    }
    
}


//MARK: - AdoptionCustomCollectionViewLayoutDelegate
extension AdoptionViewController: AdoptionCustomCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        #warning("PLACEHOLDER")
        let image = indexPath.item % 2 == 0 ? R.image.images.doggoTest2() : R.image.images.doggoTest()
        
        return indexPath.item % 2 == 0 ? 180 : 200
    }
}
