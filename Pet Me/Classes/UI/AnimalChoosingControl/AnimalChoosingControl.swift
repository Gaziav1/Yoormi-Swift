//
//  AnimalChoosingControl.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

enum AnimalTypes: String, CaseIterable {
    case cat = "Кошки"
    case dog = "Собаки"
    
    var image: UIImage? {
        switch self {
        case .cat:
            return R.image.icons.catChoice()
        case .dog:
            return R.image.icons.dogChoice()
        }
    }
    
    //Используется для запросов конкретного типа животного
    var requestString: String {
        switch self {
        case .dog:
            return "dog"
        case .cat:
            return "cat"
        }
    }
}

class AnimalChoosingStack: UIView {
    
    private let disposeBag = DisposeBag()
    private let choosenAnimalTypeEvent = BehaviorSubject<AnimalTypes>(value: .dog)
    
    private let animalTypesViews = AnimalTypes.allCases.map { AnimalChoosingControl(animalType: $0) }
    private lazy var stackView = UIStackView(arrangedSubviews: animalTypesViews)
    private var currentSelectedType: AnimalTypes = .dog {
        didSet {
            let oldSelectedType = animalTypesViews.first(where: { $0.currentType == oldValue})
            oldSelectedType?.deselect()
        }
    }
    
    var choosenAnimalTypeObservable: Observable<AnimalTypes> {
        return choosenAnimalTypeEvent.asObservable()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupSubcription()
        //force tap dog type
        animalTypesViews.first(where: { $0.currentType == currentSelectedType })?.tapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        stackView.spacing = 10
    }
    
    private func setupSubcription() {
        
        animalTypesViews.forEach({
            $0.choosenAnimalType.subscribe(onNext: { [weak self] element in
                self?.currentSelectedType = element
                self?.choosenAnimalTypeEvent.onNext(element)
            }).disposed(by: disposeBag)
        })
    }
}


class AnimalChoosingControl: UIView {
    
    private let event = PublishSubject<AnimalTypes>()
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 90, height: 85)
    }
    
    var choosenAnimalType: Observable<AnimalTypes> {
        return event.asObservable()
    }
    
    let currentType: AnimalTypes
    
    private let animalImage: UIImageView = {
        let imageView = UIImageView(image: R.image.icons.dogChoice())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerForImageView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = R.color.appColors.border()?.cgColor
        return view
    }()
    
    private let choosenView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.appColors.appMainColor()
        view.snp.makeConstraints({ $0.size.equalTo(5) })
        view.layer.cornerRadius = 5 / 2
        view.alpha = 0
        return view
    }()
    
    private let animalTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = R.color.appColors.label()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    init(animalType: AnimalTypes, frame: CGRect = .zero) {
        currentType = animalType
        super.init(frame: frame)
        animalTypeLabel.text = animalType.rawValue
        animalImage.image = animalType.image
        setupLayout()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupLayout() {
        
        containerForImageView.addSubview(animalImage)
        animalImage.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(5)
            $0.height.equalTo(intrinsicContentSize.height - 15)
            $0.width.equalTo(intrinsicContentSize.width - 15)
        })
        
        animalTypeLabel.textAlignment = .left
        
        let bottomStack = UIStackView(arrangedSubviews: [choosenView, animalTypeLabel])
        bottomStack.alignment = .center
        bottomStack.isLayoutMarginsRelativeArrangement = true
        bottomStack.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 0)
        bottomStack.spacing = 5
        
        
        addSubview(bottomStack)
        bottomStack.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        })
        
        addSubview(containerForImageView)
        containerForImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomStack.snp.top).offset(-10)
        })
        
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    private func didSelect() {
        self.containerForImageView.backgroundColor = R.color.appColors.appMainColor()
        self.choosenView.alpha = 1
    }
    
    func deselect() {
        self.containerForImageView.backgroundColor = .clear
        self.choosenView.alpha = 0
    }
    
    @objc func tapped() {
        event.onNext(currentType)
      
        UIView.animate(withDuration: 0.6) { [unowned self] in
            didSelect()
        }
    }
}
