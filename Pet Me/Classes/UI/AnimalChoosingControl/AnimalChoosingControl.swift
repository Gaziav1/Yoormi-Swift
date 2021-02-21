//
//  AnimalChoosingControl.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift

enum AnimalTypes: String {
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
}


class AnimalChoosingControl: UIView {
    
    private let event = PublishSubject<AnimalTypes>()
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 150, height: 50)
    }
    
    var choosenAnimalType: Observable<AnimalTypes> {
        return event.asObservable()
    }
    
    
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
        animalImage.snp.makeConstraints{ $0.edges.equalToSuperview().inset(10)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
        
        animalTypeLabel.textAlignment = .left
        
        let bottomStack = UIStackView(arrangedSubviews: [choosenView, animalTypeLabel])
        bottomStack.alignment = .center
        bottomStack.isLayoutMarginsRelativeArrangement = true
        bottomStack.layoutMargins = .init(top: 0, left: 1, bottom: 0, right: 0)
        bottomStack.spacing = 5
        
        let stackView = UIStackView(arrangedSubviews: [containerForImageView, bottomStack])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        animalTypeLabel.snp.makeConstraints({ $0.height.equalTo(10) })
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    
    @objc private func tapped() {
        guard let text = animalTypeLabel.text, let animalType = AnimalTypes(rawValue: text) else { return }
        event.onNext(animalType)
        containerForImageView.backgroundColor = R.color.appColors.appMainColor()
        
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.containerForImageView.backgroundColor = R.color.appColors.appMainColor()
            self.choosenView.alpha = 1
        }
    }
}
