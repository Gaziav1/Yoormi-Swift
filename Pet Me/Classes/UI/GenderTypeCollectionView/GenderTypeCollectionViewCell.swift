//
//  GenderTypeCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Lottie

class GenderTypeCollectionViewCell: UICollectionViewCell {
    
    private let genderLabel: UILabel = {
       let label = UILabel()
        label.text = "Хаски"
        label.numberOfLines = 1
        label.textColor = R.color.appColors.background()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
  
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? R.color.appColors.appMainColor() : R.color.appColors.lightBackground()
            genderLabel.textColor = isSelected ? .white : R.color.appColors.background()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.8, y: 0.8) : .identity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(genderLabel)
        
        genderLabel.snp.makeConstraints({ $0.center.equalToSuperview() })
   
        backgroundColor = R.color.appColors.lightBackground()
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
