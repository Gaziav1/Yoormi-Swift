//
//  CardView.swift
//  Yoormi
//
//  Created by 1 on 29.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit

class CardView: UIView {
  
    private var animalImages = UIImageView(image: R.image.images.doggoTest2())
    private let bottomView = CardViewBottomInfoView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImages()
        backgroundColor = .systemGray3
        setupCardViewBottomView()
        clipsToBounds = true
        layer.cornerRadius = 15
        setupPanGesture()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFromItems(_ items: [CardViewItem]) {
        print(items)
        let url = URL(fileURLWithPath: items[0].imageURLs[0])
        animalImages.sd_setImage(with: url, completed: nil)
    }
    
    private func setupCardViewBottomView() {
        addSubview(bottomView)
        
        bottomView.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(-7)
            $0.leading.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(30)
        })
    }
    
    private func setupImages() {
        addSubview(animalImages)
        animalImages.contentMode = .scaleAspectFill
        animalImages.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggingAction))
        addGestureRecognizer(panGesture)
    }
    
    
    @objc private func draggingAction(_ sender: UIPanGestureRecognizer) {
        let translatinInSuperview = sender.translation(in: superview)
        let x = translatinInSuperview.x
        let y = translatinInSuperview.y
        let rotationalAngle = x / 20
        
        switch sender.state {
        case .began:
            transform = .identity
        case .changed:
            transform = CGAffineTransform(translationX: x, y: y).rotated(by: rotationalAngle * .pi / 180)
        case .ended:
            dismissIfNeeded(x)
        case .failed, .cancelled:
            transform = .identity
        default:
            ()
        }
    }
    
   
    private func dismissIfNeeded(_ translation: CGFloat) {
        let absTranslation = abs(translation)

        guard absTranslation > 175 else {
            animate([.initialTransformAnimation(time: 0.4)])
            return
        }
        
        let dimissSide: CGFloat = translation > 1 ? 700 : -500
        let dismiss = CABasicAnimation(keyPath: "position.x")
        
        dismiss.delegate = self
        dismiss.toValue = dimissSide
        dismiss.duration = 0.5

        layer.add(dismiss, forKey: nil)
    }
}


extension CardView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeFromSuperview()
    }
}
