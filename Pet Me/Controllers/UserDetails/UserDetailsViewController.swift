//
//  UserDetailsViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 12.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailsViewController: UIViewController {
    
    var cardViewModel: CardViewModel? {
        didSet {
            infoLabel.attributedText = cardViewModel?.attributedString
            swipingPhotosController.cardViewModel = cardViewModel
            //cardViewModel?.imageNames.forEach({ imageView.sd_setImage(with: URL(string: $0))})
        }
    }
    
    lazy var swipingView = swipingPhotosController.view!
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    
    let swipingPhotosController = SwipingPhotosPageViewController()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Gosha, 30\nRapper"
        label.numberOfLines = 0
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleTapDismiss), for: .touchUpInside)
        return button
    }()
    
    fileprivate let heightForSwipingView: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .fullScreen
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        setupScrollView()
        setupSwipingView()
        setupDismissButton()
        setupInfoLabel()
        setupVisualEffectView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
          handleScrollingBehavior()
    }
    
    
    //MARK: - UI Setup
    
    fileprivate func setupVisualEffectView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        view.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints({
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
    
        scrollView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    fileprivate func setupDismissButton() {
        view.addSubview(dismissButton)
        
        dismissButton.snp.makeConstraints({
            $0.top.equalTo(swipingView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(50)
        })
    }
    
    fileprivate func setupSwipingView() {

        scrollView.addSubview(swipingView)
    }
    
    fileprivate func setupInfoLabel() {
        scrollView.addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints({
            $0.top.equalTo(swipingView.snp.bottom).offset(16)
            $0.leading.equalTo(view).inset(16)
            $0.trailing.equalTo(dismissButton.snp.leading).offset(5)
        })
    }
    
    fileprivate func handleScrollingBehavior() {
        let y = scrollView.contentOffset.y
        let width = max(view.frame.width - y , view.frame.width)
        swipingView.frame = CGRect(x: 0, y: y, width: width, height: width + heightForSwipingView)
        swipingView.center.x = scrollView.center.x
    }
    
    //MARK: - Objc Actions
    @objc fileprivate func handleTapDismiss() {
        self.dismiss(animated: true)
    }
    
}


