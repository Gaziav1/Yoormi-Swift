//
//  CardView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            let imageName = cardViewModel.imageNames.first ?? ""
            
            if let url = URL(string: imageName) {
                imageView.sd_setImage(with: url)
            }
            
            descriptionLabel.attributedText = cardViewModel.attributedString
            descriptionLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach({ _ in
                let barView = UIView()
                barView.layer.cornerRadius = 2
                barView.clipsToBounds = true
                barView.backgroundColor = deselectedViewColor
                barsStackView.addArrangedSubview(barView)
            })
            barsStackView.subviews.first?.backgroundColor = .white
            setupImageIndexObserver()
            
        }
    }
    
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
        setupLabel()
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    //MARK: - FilePrivate Methods
    
    fileprivate func setupLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
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
        let degrees: CGFloat = translation.x / 20
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
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                self.layer.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
                
            } else {
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
