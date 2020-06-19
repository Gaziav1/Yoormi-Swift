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
    func didSelectMoreInfoButton()
    func didDislikeUser()
    func didLikeUser()
}

class CardView: UIView {
    
    private(set) var uid = ""
     
    weak var delegate: CardViewDelegate?
    
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Asset.Icons.infoIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleMoreInfo), for: .touchUpInside)
        return button
    }()
    
    fileprivate let barsStackView = UIStackView()
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate var imageNames = [String]() {
        didSet {
            for _ in imageNames {
                //Настраиваем планки сверху по колчиству изображений
                 let barView = UIView()
                 barView.layer.cornerRadius = 2
                 barView.clipsToBounds = true
                 barView.backgroundColor = .appDeselectStateColor
                 barsStackView.addArrangedSubview(barView)
             }
             
             profileImageView.sd_setImage(with: URL(string: imageNames[0]))
             barsStackView.subviews.first?.backgroundColor = .white
        }
    }
    
    fileprivate var profileImageView = UIImageView()
    fileprivate var imageIndex = 0
    fileprivate let descriptionLabel = UILabel()
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
    
    func setupCardView(from user: AppUser) {
        let attributedText = NSMutableAttributedString(string: user.name ?? "Без имени", attributes: [.font: UIFont.systemFont(ofSize: 26, weight: .heavy)])
        attributedText.append(NSAttributedString(string: ", \(user.age ?? 0)", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(String(describing: user.description))", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
        
        descriptionLabel.attributedText = attributedText
        descriptionLabel.textAlignment = .left
        
        imageNames = user.imageNames
        uid = user.uid
    }
    
    //MARK: - FilePrivate Methods
    
    fileprivate func setupInfoButton() {
        addSubview(moreInfoButton)
        
        moreInfoButton.snp.makeConstraints({
            $0.bottom.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(41)
        })

    }
    
    fileprivate func setupLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints({
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.trailing.equalTo(moreInfoButton.snp.leading).offset(5)
        })
        
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
    }
    
    fileprivate func setupImage() {
        addSubview(profileImageView)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.65, 1.1]
        
        layer.addSublayer(gradientLayer)
    }
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        
        barsStackView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(5)
        })
        
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
    
  
    // MARK: - Actions
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        
        if shouldAdvanceNextPhoto {
            imageIndex = min(imageIndex + 1, imageNames.count)
        } else {
            imageIndex = max(imageIndex - 1, 0)
        }
        
        let imageURL = URL(string: imageNames[imageIndex])
        profileImageView.sd_setImage(with: imageURL)
        
        barsStackView.arrangedSubviews.forEach({ $0.backgroundColor = .appDeselectStateColor })
        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
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
        delegate?.didSelectMoreInfoButton()
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
