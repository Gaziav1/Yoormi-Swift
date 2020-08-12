//
//  DetailAdoptionBottomView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 09.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class DetailAdoptionBottomView: UIView {
    
    private let heartContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        var size = 50
        view.snp.makeConstraints({ $0.size.equalTo(size) })
        view.layer.cornerRadius = CGFloat(size / 2)
        view.layer.borderColor = R.color.appColors.border()?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let heartIcon: UIImageView = {
        let view = UIImageView(image: R.image.icons.heart())
        view.snp.makeConstraints { $0.size.equalTo(25) }
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let adoptButton: UIButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        adoptButton.backgroundColor = R.color.appColors.appMainColor()
        adoptButton.setAttributedTitle(NSAttributedString(string: "Написать хозяину", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.white as Any]), for: .normal)
        setupUI()
         adoptButton.layer.cornerRadius = 23
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(heartContainerView)
        
        heartContainerView.addSubview(heartIcon)
        heartIcon.snp.makeConstraints { $0.center.equalToSuperview() }
        
        let stackView = UIStackView(arrangedSubviews: [heartContainerView, adoptButton])
        
        addSubview(stackView)
        stackView.spacing = 20
        
        stackView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
}
