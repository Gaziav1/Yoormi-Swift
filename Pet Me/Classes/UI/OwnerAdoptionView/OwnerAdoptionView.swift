//
//  OwnerAdoptionView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 09.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class OwnerAdoptionView: UIView {
    
    private let avatarImageView: UIImageView = {
        let iv = UIImageView(image: R.image.images.avatarTest())
        let size = 70
        iv.snp.makeConstraints { $0.size.equalTo(size) }
        iv.layer.cornerRadius = CGFloat(size / 2)
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Андрей Иванович"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = R.color.appColors.darkLabel()
        label.numberOfLines = 2
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let ownerStaticLabel: UILabel = {
        let label = UILabel()
        label.text = "Хозяин"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = R.color.appColors.label()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let dateOfAdLabel: UILabel = {
        let label = UILabel()
        label.text = "24.01.2020"
        label.textAlignment = .right
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = R.color.appColors.label()
        return label
    }()
    
    
    private let animalDescription: UILabel = {
        let label = UILabel()
        label.text = "Static Text - это элемент гибкого описания, позволяющий найти заранее известный текст. Текст может состоять из одного слова, а может содержать фразу, состоящую из нескольких слов. Фраза отличается от слова тем, что внутри нее есть хотя бы один пробел, при этом фраза может располагаться на нескольких строках. "
        label.numberOfLines = 0

        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = R.color.appColors.darkLabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        
        let labelsStack = UIStackView(arrangedSubviews: [ownerNameLabel, ownerStaticLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 3
        
        let topStack = UIStackView(arrangedSubviews: [avatarImageView, labelsStack, dateOfAdLabel])
        
        topStack.spacing = 8
        topStack.alignment = .center
        
        let overallStack = UIStackView(arrangedSubviews: [topStack, animalDescription])
        overallStack.axis = .vertical
        overallStack.spacing = 15
        overallStack.isLayoutMarginsRelativeArrangement = true
        overallStack.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        addSubview(overallStack)
        overallStack.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
    }
}

