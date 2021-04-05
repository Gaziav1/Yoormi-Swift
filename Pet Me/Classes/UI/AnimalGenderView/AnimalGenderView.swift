//
//  AnimalGenderView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 01.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

enum AnimalGender: String, RawRepresentable {
    case male
    case female
}

class AnimalGenderView: UISegmentedControl {
   
    private let animalGenderSubject = BehaviorSubject<AnimalGender>(value: .male)
    var animalGenderObservable: Observable<AnimalGender> {
        return animalGenderSubject.asObservable()
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        insertSegment(withTitle: LocalizationKeys.male.localized, at: 0, animated: false)
        insertSegment(withTitle: LocalizationKeys.female.localized, at: 1, animated: false)
        
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let notSelectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        setTitleTextAttributes(notSelectedTitleTextAttributes, for: .normal)
        
        selectedSegmentIndex = 0
        selectedSegmentTintColor = .systemBlue
        
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAction() {
        addTarget(self, action: #selector(didChangeSelection), for: .valueChanged)
    }
    
    @objc private func didChangeSelection() {
        selectedSegmentTintColor = selectedSegmentIndex == 0 ? .systemBlue : .systemPink

        let choosenAnimalGender: AnimalGender = selectedSegmentIndex == 0 ? .male : .female
        animalGenderSubject.onNext(choosenAnimalGender)
    }
}
