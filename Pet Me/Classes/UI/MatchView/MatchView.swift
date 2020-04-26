//
//  MatchView.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 06.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import Firebase

class MatchView: UIView {
    
    var currentUser: AppUser! {
        didSet {
            
            self.currentUserImageView.sd_setImage(with: URL(string: currentUser.imageNames[0]))
           
                
            }
        }
    
    var cardUID: String! {
        didSet {
            Firestore.firestore().collection("users").document(cardUID).getDocument { (snapshot, error) in
                if let err = error {
                    print("Failed to ferch card UID")
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                let user = AppUser(dictionary: data)
                self.cardUserImage.alpha = 1
                self.cardUserImage.sd_setImage(with: URL(string: user.imageNames[0]), completed: nil)
                
            }
        }
    }
    
    fileprivate let currentUserImageView: UIImageView = {
        let imageView = UIImageView(image: Asset.Placeholders.doggoPlaceholder2)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You and Bobby liked each other"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21)
        return label
    }()
    
    fileprivate let sendMessageButton: GradientButton = {
        let button = GradientButton(type: .system)
        button.setTitle("Отправить сообщение", for: .normal)
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    fileprivate let cardUserImage: UIImageView = {
        let imageView = UIImageView(image: Asset.Placeholders.doggoPlaceholder2)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.alpha = 0
        return imageView
    }()
    
    fileprivate let visualView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBlurView()
        setupCurrentUserImage()
        setupCardUserImage()
        setupDescriptionLabel()
        setupSendMessageButton()
        setupAnimation()
    }
    
    fileprivate func setupAnimation() {
        let angle = 30 * CGFloat.pi / 180
        
        
        sendMessageButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle).concatenating(CGAffineTransform(translationX: 200, y: 0))
        cardUserImage.transform = CGAffineTransform(rotationAngle: angle).concatenating(CGAffineTransform(translationX: -200, y: 0))
        
        UIView.animateKeyframes(withDuration: 1.2, delay: 1, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.35) {
                self.currentUserImageView.transform = CGAffineTransform(rotationAngle: -angle)
                self.cardUserImage.transform = CGAffineTransform(rotationAngle: angle)
                self.sendMessageButton.transform = .identity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.currentUserImageView.transform = .identity
                self.cardUserImage.transform = .identity
            }
            
        }, completion: nil)
    }
    
    
    fileprivate func setupCurrentUserImage() {
        addSubview(currentUserImageView)
        
        currentUserImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16), size: .init(width: 140, height: 140))
        currentUserImageView.layer.cornerRadius = 140 / 2
        currentUserImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    fileprivate func setupCardUserImage() {
        addSubview(cardUserImage)
        cardUserImage.anchor(top: nil, leading: centerXAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0), size: .init(width: 140, height: 140))
        cardUserImage.layer.cornerRadius = 140 / 2
        cardUserImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    fileprivate func setupBlurView() {
        
        visualView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDismiss)))
        addSubview(visualView)
        visualView.fillSuperview()
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 1
        }) { (_) in
            
        }
    }
    
    fileprivate func setupSendMessageButton() {
        addSubview(sendMessageButton)
        
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 48, bottom: 0, right: 48), size: .init(width: 0, height: 60))
        
        sendMessageButton.layer.cornerRadius = 60 / 2
    }
    
    fileprivate func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: currentUserImageView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 32, right: 0), size: .init(width: 0, height: 50))
    }
    
    @objc fileprivate func tapDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
