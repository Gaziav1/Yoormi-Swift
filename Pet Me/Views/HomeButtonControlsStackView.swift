//
//  HomeButtonControlsStackView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class HomeButtonControlsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let images = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")]
       
        images.forEach { (img) in
            let button = UIButton(type: .system)
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            addArrangedSubview(button)
        }
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
