//
//  CreateAdChooseTypeCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//


import UIKit

class CreateAdChooseTypeCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Выберите породу"
        label.numberOfLines = 1
        label.textColor = .white
        label.alpha = 0.5
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    
    private let collectionView: GenderTypeCollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = GenderTypeCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
         addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)

        })
        
        collectionView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
