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
    
    var output: CreateAdViewOutput!
    
    private let disposeBag = DisposeBag()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    //MARK: - UI Properties
    private let stepsCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: fl)
        cv.register(CreateAdStepsCollectionCell.self)
        fl.scrollDirection = .horizontal
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        return cv
    }()
    
    
    //MARK: - UI Setup
    
    private func setupStepsCollectionView() {
        view.addSubview(stepsCollectionView)
        stepsCollectionView.delegate = self
        stepsCollectionView.dataSource = self
        stepsCollectionView.showsHorizontalScrollIndicator = false
        
        stepsCollectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}

// MARK: - CreateAdViewInput
extension CreateAdViewController: CreateAdViewInput {
    
    func setupInitialState() {
        view.backgroundColor = .white
        setupStepsCollectionView()
    }
    
    func openImageController() {
    }
}

//MARK: - UICollectionViewDelegate & DataSource
extension CreateAdViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CreateAdStepsCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CreateAdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 10, height: view.frame.height)
    }
}


