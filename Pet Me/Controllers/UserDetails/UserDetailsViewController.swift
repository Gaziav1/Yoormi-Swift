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
        visualEffectView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor)
    }
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
    
        scrollView.fillSuperview()
    }
    
    fileprivate func setupDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.anchor(top: swipingView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 10), size: CGSize(width: 50, height: 50))
    }
    
    fileprivate func setupSwipingView() {

        scrollView.addSubview(swipingView)
    }
    
    fileprivate func setupInfoLabel() {
        scrollView.addSubview(infoLabel)
        
        infoLabel.anchor(top: swipingView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: dismissButton.leadingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 5))
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


