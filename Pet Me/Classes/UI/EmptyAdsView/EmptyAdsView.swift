//
//  EmptyAdsView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 11.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EmptyAdsView: UIView {
    
    var tapObserver: Observable<Void> {
        return addAdButton.rx.controlEvent(.touchUpInside).asObservable()
    }
    
    private let emptyLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.text = "У вас еще нет объявлений"
        label.textColor = R.color.appColors.label()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let addAdButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Разместить объявление", for: .normal)
        button.setTitleColor(.link, for: .normal)
        
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emptyLabel, addAdButton])
        stackView.axis = .vertical

        stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}


