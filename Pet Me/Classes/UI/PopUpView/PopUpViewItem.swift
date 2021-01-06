//
//  PopUpViewItem.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.12.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum PopViewItemType: CaseIterable {
    case takePhoto
    case choosePhoto
    case noPhoto
}

class PopUpViewItem: UIView {
    
    private let diposeBag = DisposeBag()
    private let publishSubject = PublishSubject<PopViewItemType>()
    private var type: PopViewItemType
    
    var tapObservable: Observable<PopViewItemType> {
        return publishSubject.asObservable()
    }
    
    private let imageView = UIImageView(image: nil)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = R.color.appColors.button()!
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    init(frame: CGRect = .zero, type: PopViewItemType) {
        self.type = type
        super.init(frame: frame)
        backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        layer.cornerRadius = 5
        defineContentFrom(type: type)
        setupLayout()
        setupObservable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineContentFrom(type: PopViewItemType) {
        let tintColor = R.color.appColors.button() ?? .link
        switch type {
        case .takePhoto:
            imageView.image = R.image.icons.camera()?.withTintColor(tintColor)
            titleLabel.text = "Снимок"
        case .choosePhoto:
            imageView.image = R.image.icons.plus()?.withTintColor(tintColor)
            titleLabel.text = "Загрузить"
        case .noPhoto:
            imageView.image = R.image.icons.profile_empty()?.withTintColor(tintColor)
            titleLabel.text = "Без фото"
        }
    }
    
    private func setupObservable() {
        let gestureRec = UITapGestureRecognizer()
        addGestureRecognizer(gestureRec)
        
        gestureRec.rx.event.bind(onNext: { element in
            self.publishSubject.onNext(self.type)
        }).disposed(by: diposeBag)
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(20)
            $0.size.equalTo(70)
        })
    }
}
