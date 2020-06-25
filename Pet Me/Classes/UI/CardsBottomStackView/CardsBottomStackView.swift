//
//  HomeButtonControlsStackView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

protocol CardBottomStackViewDelegate: class {
    func didTapRefreshButton()
    func didTapCloseButton()
    func didTapLikeButton()
}

class CardsBottomStackView: UIStackView {
    
    weak var delegate: CardBottomStackViewDelegate?
    
    private let refreshButton = createButton(image: R.image.icons.refresh_circle(), action: #selector(didTapRefreshButton))
    private let closeButton = createButton(image: R.image.icons.close(), action: #selector(didTapCloseButton))
    private let likeButton = createButton(image: R.image.icons.like_circle(), action: #selector(didTapLikeButton))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [closeButton, likeButton, refreshButton].forEach{ addArrangedSubview($0) }
        
        heightAnchor.constraint(equalToConstant: 65).isActive = true
        distribution = .fillEqually
        spacing = 100
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate static func createButton(image: UIImage?, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    @objc private func didTapRefreshButton() {
        delegate?.didTapRefreshButton()
    }
    
    @objc private func didTapCloseButton() {
        delegate?.didTapCloseButton()
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    
}
