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


enum CreateAdStep: Int, CaseIterable {
    case mainInfo
    case photoAndDescription
    case mapAndAdress
    case final
}


class CreateAdViewController: UIViewController {
    
    var output: CreateAdViewOutput!
    
    private let disposeBag = DisposeBag()
    private let steps = CreateAdStep.allCases
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    //MARK: - UI Properties
    private let stepsCollectionView: UICollectionView = {
        let fl = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: fl)
        cv.register(MainAdInfoCollectionViewCell.self)
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
        navigationController?.navigationBar.backgroundColor = .clear
        stepsCollectionView.snp.makeConstraints({
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
    
    func showError(_ description: String) {
        let alertController = UIAlertController.prepareErrorController(body: description)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAnimalSubtypes(_ subtypesItem: [AnimalSubtypeCellItem]) {
        guard let subtypesCell = stepsCollectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? MainAdInfoCollectionViewCell else { return }
        subtypesCell.setupAnimalSubtypes(subtypesItem)
    }
    
}

//MARK: - UICollectionViewDelegate & DataSource
extension CreateAdViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let step = CreateAdStep(rawValue: indexPath.item)
        switch step {
        case .mainInfo:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MainAdInfoCollectionViewCell
            
            cell.animalTypeChoiceObservable.subscribe(onNext: { [weak self] choosenAnimalType in
                self?.output.fetchAnimalSubtype(choosenAnimalType)
            }).disposed(by: disposeBag)
            
            cell.userChoosenInfoObservable.subscribe(onNext: { [weak self] firstStepUserInfo in
                self?.output.saveFirstStepUserInfo(firstStepUserInfo)
            }).disposed(by: disposeBag)
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MainAdInfoCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CreateAdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: stepsCollectionView.frame.height)
    }
}


