//
//  MessagesTopView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 12.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class MessagesTopView: UIView {
    
    fileprivate let iconImageView = UIImageView(image: Asset.Icons.messagesIcon.withRenderingMode(.alwaysTemplate))
    fileprivate let messagesLabel = UILabel()
    fileprivate let feedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        dropShadow(shadowOffset: .init(width: 0, height: 5))
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        setupImage()
        setupLabels()
        
        let hrsStack = UIStackView(arrangedSubviews: [messagesLabel, feedLabel])
        hrsStack.distribution = .fillEqually
       
        let stack = UIStackView(arrangedSubviews: [iconImageView, hrsStack])
        stack.axis = .vertical
        
        addSubview(stack)
        stack.fillSuperview()
    }
    
    fileprivate func setupImage() {
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .appLightGreen
        iconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    fileprivate func setupLabels() {
        
        messagesLabel.text = "Сообщения"
        messagesLabel.font = UIFont.systemFont(ofSize: 20)
        messagesLabel.textAlignment = .center
        messagesLabel.textColor = .appLightGreen
        
        feedLabel.text = "Лента"
        feedLabel.textAlignment = .center
        feedLabel.font = UIFont.systemFont(ofSize: 20)
        feedLabel.textColor = .secondaryLabel
    }
}
