//
//  CardView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import SDWebImage

protocol CardViewDelegate: class {
    func didSelectMoreInfoButton(cardViewModel: CardViewModel)
    func didDislikeUser()
    func didLikeUser()
    
}

class CardView: UIView {
     
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.imageNames.first ?? ""
            
            if let url = URL(string: imageName) {
                imageView.sd_setImage(with: url)
            }
            
            descriptionLabel.attributedText = cardViewModel.attributedString
            descriptionLabel.textAlignment = cardViewModel.textAlignment
            
            
            for _ in cardViewModel.imageNames {
                let barView = UIView()
                barView.layer.cornerRadius = 2
                barView.clipsToBounds = true
                barView.backgroundColor = deselectedViewColor
                barsStackView.addArrangedSubview(barView)
            }
           
            barsStackView.subviews.first?.backgroundColor = .white
            setupImageIndexObserver()
        }
    }
    
    weak var delegate: CardViewDelegate?
    
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "info")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMoreInfo), for: .touchUpInside)
        return button
    }()
    
    fileprivate let deselectedViewColor = UIColor(white: 0, alpha: 0.15)
    fileprivate let barsStackView = UIStackView()
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "DoggoTest"))
    fileprivate let descriptionLabel = UILabel()
    
    //Configurations
    fileprivate let threshold: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        setupImage()
        setupBarsStackView()
        setupGradientLayer()
        setupInfoButton()
        setupLabel()
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    //MARK: - FilePrivate Methods
    
    fileprivate func setupInfoButton() {
        addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 00, left: 0, bottom: 16, right: 16), size: .init(width: 41, height: 44))
    }
    
    fileprivate func setupLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: moreInfoButton.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 5))
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
    }
    
    fileprivate func setupImage() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.65, 1.1]
        
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 5))
        
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
    }
    
    fileprivate func handleDragging(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 15
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle).translatedBy(x: translation.x, y: translation.y)
        
        transform = rotationalTransformation
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [unowned self] (idx, imageURL) in
            if let imageURL = URL(string: imageURL ?? "") {
                self.imageView.sd_setImage(with: imageURL)
            }
            self.barsStackView.arrangedSubviews.forEach({ (v) in
                v.backgroundColor = self.deselectedViewColor
            })
            self.barsStackView.arrangedSubviews[idx].backgroundColor = .white
        }
    }
    
    
    // MARK: - Actions
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            self.superview?.subviews.last?.layer.removeAllAnimations()
        case .changed:
            handleDragging(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    @objc fileprivate func handleMoreInfo() {
        delegate?.didSelectMoreInfoButton(cardViewModel: cardViewModel)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
    
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        if shouldDismissCard {
            translationDirection == 1 ? self.delegate?.didLikeUser() : self.delegate?.didDislikeUser()
        } else {
           
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
            })
            
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
