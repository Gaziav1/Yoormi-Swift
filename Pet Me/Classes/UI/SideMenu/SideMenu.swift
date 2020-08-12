//
//  SideMenu.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class SideMenu: UIViewController {
    //MARK: - Private properties
    
    private let contentViewContainer = UIView()
    private let menuViewContainer = UIView()
    private var visible = false
    private var contentViewInPortraitOffsetCenterX: CGFloat = 80.0
    private let visualEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThinMaterial)
        let visualEffectView = UIVisualEffectView(effect: blur)
        visualEffectView.alpha = 0
        visualEffectView.isHidden = true
        return visualEffectView
    }()
    private lazy var dismissGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dimissMenu))
    private lazy var panDismissGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panDraggingAction))
    
    
    //MARK: - Public properties
    
    var contentVC: UIViewController? {
        willSet {
            setupViewController(contentViewContainer, targetViewController: newValue)
        }
        didSet {
            if let controller = oldValue {
                hideViewController(controller)
            }
        }
    }
    
    var rightMenuVC: UIViewController? {
        willSet {
            setupViewController(menuViewContainer, targetViewController: newValue)
        }
        didSet {
            if let controller = oldValue {
                hideViewController(controller)
            }
            view.bringSubviewToFront(contentViewContainer)
        }
    }
    
    //MARK: - Initializers
    
    convenience init(contentVC: UIViewController, rightMenuVC: UIViewController) {
        self.init()
        self.contentVC = contentVC
        self.rightMenuVC = rightMenuVC
    }
    
    //MARK: - Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addFlexWidthAndHeigt()
        
        menuViewContainer.frame = view.bounds
        menuViewContainer.addFlexWidthAndHeigt()
        
        contentViewContainer.frame = view.bounds
        contentViewContainer.addFlexWidthAndHeigt()
        
        setupViewController(contentViewContainer, targetViewController: contentVC)
        setupViewController(menuViewContainer, targetViewController: rightMenuVC)
        
        view.addSubview(menuViewContainer)
        view.addSubview(contentViewContainer)
        contentViewContainer.addSubview(visualEffectView)
        visualEffectView.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    
    //MARK: - Setup
    private func setupViewController(_ targetView: UIView, targetViewController: UIViewController?) {
        if let controller = targetViewController {
            addChild(controller)
            controller.view.frame = view.bounds
            controller.view.addFlexWidthAndHeigt()
            targetView.addSubview(controller.view)
            controller.didMove(toParent: self)
        }
    }
    
    private func hideViewController(_ targetViewController: UIViewController) {
        targetViewController.willMove(toParent: nil)
        targetViewController.view.removeFromSuperview()
        targetViewController.removeFromParent()
    }
    
    //MARK: - Present / Hide Menu ViewControllers
    
    func _presentRightMenuViewController() {
        showRightMenuViewController()
    }
    
    private func showRightMenuViewController() {
        visualEffectView.isHidden = false
        
        if let rightController = rightMenuVC {
            //showmenuviewcontroller
            
            UIView.animate(withDuration: 0.35, animations: { [unowned self] in
                self.animateMenuViewController()
                },
                completion: { [weak self] _ in
                self?.animateMenuViewControllerCompletion(menuViewController: rightController)
            })
        }
    }
    
    private func animateMenuViewController() {
        contentViewContainer.transform = .identity
        contentViewContainer.frame = .init(x: (view.center.x + contentViewInPortraitOffsetCenterX), y: view.frame.origin.y, width: view.frame.width, height: view.frame.height)
        visualEffectView.alpha = 1
    }
    
    private func animateMenuViewControllerCompletion(menuViewController: UIViewController? = nil) {
        
        visible.toggle()
        
        if visible {
            visualEffectView.addGestureRecognizer(dismissGesture)
            view.addGestureRecognizer(panDismissGesture)
        } else {
            visualEffectView.isHidden = true
            visualEffectView.removeGestureRecognizer(dismissGesture)
            view.removeGestureRecognizer(panDismissGesture)
        }
        
        //rightMenuVC?.endAppearanceTransition()
        view.isUserInteractionEnabled = true
        
    }
    
    
    //MARK: - Actions
    
    func hideMenu() {
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.35, animations: { [unowned self] in
            self.contentViewContainer.frame = self.view.frame
            self.visualEffectView.alpha = 0
            
            }, completion: { [weak self] _ in
                self?.animateMenuViewControllerCompletion()
                
        })
    }
    
    @objc private func dimissMenu() {
        hideMenu()
    }
    
    
    @objc private func panDraggingAction(_ pan: UIPanGestureRecognizer) {
        
        switch pan.state {
        case .changed:
           
        contentViewContainer.transform = CGAffineTransform(translationX: pan.translation(in: view).x, y: menuViewContainer.frame.origin.y)
        print(pan.translation(in: view).x)

        case .ended:
            
            if pan.translation(in: view).x < -145 {
                dimissMenu()
            } else {
                UIView.animate(withDuration: 0.2) { [unowned self] in
                    self.contentViewContainer.transform = .identity
                }
            }
            
        default:
            ()
        }
    }
}
