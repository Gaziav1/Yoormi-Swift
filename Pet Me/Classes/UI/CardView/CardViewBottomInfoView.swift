//
//  CardViewBottomInfoView.swift
//  Yoormi
//
//  Created by 1 on 29.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit

class CardViewBottomInfoView: UIView {
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let isMaleImageView: UIImageView = {
        let iv = UIImageView(image: R.image.icons.boy())
        return iv
    }()
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 50, height: 100)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        alpha = 0.8
        layer.cornerRadius = 10
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        addSubview(title)
        
        title.snp.makeConstraints({
            $0.top.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().offset(-15)
        })
    }
}
