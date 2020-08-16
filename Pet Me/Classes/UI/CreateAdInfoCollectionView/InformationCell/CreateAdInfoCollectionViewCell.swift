//
//  CreateAdInfoCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class CreateAdInfoCollectionViewCell: UICollectionViewCell {
    
    private let infoTextField = AdsTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(infoTextField)
        
        infoTextField.snp.makeConstraints({
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
