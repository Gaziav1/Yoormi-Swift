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
    private var contentViewInPortraitOffsetCenterX: Float = 80.0
    
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
    }
    
    
    //MARK: - Setup
    private func setupViewController(_ targetView: UIView, targetViewController: UIViewController?) {
        if let controller = targetViewController {
            addChild(controller)
            controller.view.frame = view.bounds
            controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        contentViewContainer.center = CGPoint(x:  CGFloat(-contentViewInPortraitOffsetCenterX), y: contentViewContainer.center.y)
    }
    
    private func animateMenuViewControllerCompletion(menuViewController: UIViewController) {
        
        visible = true
        //rightMenuVC?.endAppearanceTransition()
        view.isUserInteractionEnabled = true
    }
}
