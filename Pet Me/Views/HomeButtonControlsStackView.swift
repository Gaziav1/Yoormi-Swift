//
//  HomeButtonControlsStackView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class HomeButtonControlsStackView: UIStackView {
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))
    let closeButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
    let starButton = createButton(image: #imageLiteral(resourceName: "super_like_circle"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "like_circle"))
    let lightingButton = createButton(image: #imageLiteral(resourceName: "boost_circle"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [refreshButton, closeButton, starButton, likeButton, lightingButton].forEach{ addArrangedSubview($0) }
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
}
