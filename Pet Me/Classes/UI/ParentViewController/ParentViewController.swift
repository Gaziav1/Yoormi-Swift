//
//  ParentViewController.swift
//  Yoormi
//
//  Created by Газияв Исхаков on 05.09.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//
//AAAAAAAAAAAA
import UIKit
import Lottie


//TODO: Вынести в отдельные файлы, сделать экшн для ошибки, прокинуть модель объявления и сделать вью модель, сделать нормальный скролл для коллекции и подумать над изображениями

struct IndicationConfiguration {
    let title: LocalizationKeys
    let animationName: String
    let imageName: String
}

extension IndicationConfiguration {
    static let loading = IndicationConfiguration(title: .loadingState, animationName: LottieAnimations.loadingIndicatior, imageName: "")
    static let loadingCat = IndicationConfiguration(title: .loadingState, animationName: LottieAnimations.rollingCatAnimation, imageName: "")
}

class IndicationView: UIView {
  
    private let indicationImage: UIImageView = {
       let iv = UIImageView()
        return iv
    }()
    
    private let animationView: AnimationView = {
        let animation = AnimationView(name: LottieAnimations.loadingIndicatior)
        animation.backgroundBehavior = .pauseAndRestore
        animation.loopMode = .autoReverse
        animation.contentMode = .scaleToFill
        return animation
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel.localizedLabel(.emptyString)
        label.textColor = .lightGray
        return label
    }()
    
    init(frame: CGRect, indicationConfiguration: IndicationConfiguration) {
        super.init(frame: frame)
        backgroundColor = .white
        setupImage()
        setupAnimationView()
        setupTextTitle()
        
        if indicationConfiguration.animationName == "" {
            animationView.removeFromSuperview()
        }
        
        if indicationConfiguration.imageName == "" {
            indicationImage.removeFromSuperview()
        }
        
        if indicationConfiguration.title == .emptyString {
            textLabel.removeFromSuperview()
        }
        
        textLabel.text = indicationConfiguration.title.localized
        indicationImage.image = UIImage(named: indicationConfiguration.imageName)
        animationView.animation = Animation.named(indicationConfiguration.animationName)
        animationView.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImage() {
        addSubview(indicationImage)

        indicationImage.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(20)
        })
        
        indicationImage.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupAnimationView() {
        addSubview(animationView)
        
        animationView.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.size.equalTo(225)
            $0.top.equalTo(indicationImage.snp.bottom).offset(2000)
            $0.centerY.equalToSuperview().priority(999)
        })
    }
    
    private func setupTextTitle() {
        addSubview(textLabel)

        textLabel.snp.makeConstraints({
            $0.top.equalTo(animationView.snp.bottom).offset(10)
            $0.top.equalTo(indicationImage.snp.bottom).offset(10).priority(999)
            $0.leading.trailing.equalToSuperview().inset(10)
        })
        
        textLabel.textAlignment = .center
    }
}


class ParentViewController: UIViewController {
    
    private var indicatorView = IndicationView(frame: .zero, indicationConfiguration: .loading) {
        didSet {
            view.addSubview(indicatorView)
            indicatorView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
        }
    }
    
    
    func showIndicator(withConfiguration configuration: IndicationConfiguration) {
        indicatorView = IndicationView(frame: .zero, indicationConfiguration: configuration)
    }
    
    func hideIndication(_ animated: Bool) {
        animated ? hideIndicationAnimation() : indicatorView.removeFromSuperview()
    }
    
    private func hideIndicationAnimation() {
        UIView.animate(withDuration: 0.8, animations: {
            self.indicatorView.alpha = 0
        }, completion: { _ in
            self.indicatorView.removeFromSuperview()
        })
    }
}
