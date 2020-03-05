//
//  TopNavigationStackView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let messagesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _ = [#imageLiteral(resourceName: "app_icon")]
       
        addArrangedSubview(settingsButton)
        addArrangedSubview(messagesButton)
        
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        distribution = .fillEqually
        spacing = 100
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
