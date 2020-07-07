//
//  CustomSignInButton.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 22.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import SnapKit

enum IconPosition {
    case left, right
    case titleLeft, titleRight
}

class CustomSignInButton: UIView {
    
    var iconPosition: IconPosition = .titleLeft {
        didSet {
            makeConstraintsForIcon()
        }
    }
    
    let titleLabel = UILabel()
    let icon = UIImageView(image: R.image.icons.google())
    
    init(text: String = "Sign in with Google", icon: UIImage? = R.image.icons.google()) {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        self.titleLabel.text = text
        self.icon.image = icon
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 5
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        titleLabel.textColor = .label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(15)
        })
        
        icon.contentMode = .scaleAspectFill
        
        addSubview(icon)
        
        makeConstraintsForIcon()
    }
    
    private func makeConstraintsForIcon() {
        
        switch iconPosition {
        case .left:
            icon.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(20)
                $0.leading.equalToSuperview().inset(10)
            }
            
        case .right:
            icon.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(20)
                $0.trailing.equalToSuperview().inset(10)
            }
        case .titleLeft:
            icon.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(20)
                $0.trailing.equalTo(titleLabel.snp.leading).offset(-5)
            }
            
        case .titleRight:
            icon.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.size.equalTo(20)
                $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            }
        }
    }
}
