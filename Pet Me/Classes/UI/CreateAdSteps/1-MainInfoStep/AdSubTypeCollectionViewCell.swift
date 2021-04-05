//
//  AdSubTypeCollectionViewCell.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 20.02.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit

class AdSubTypeCollectionViewCell: UICollectionViewCell {
    
    let animalTypeLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .appLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .appDeselectStateColor
        clipsToBounds = true
        layer.cornerRadius = 10
        animalTypeLabelSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            animateHighlightedState(isHighlighted)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            animalTypeLabel.textColor = oldValue ? .black : .white
        }
    }
    
    private func animateHighlightedState(_ highlighted: Bool) {
        let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.transform = highlighted ? transform : .identity
        }
    }
    
    private func animalTypeLabelSetup() {
        addSubview(animalTypeLabel)
        
        animalTypeLabel.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
