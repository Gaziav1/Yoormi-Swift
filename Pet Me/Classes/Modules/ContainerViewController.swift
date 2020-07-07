//
//  ContainerViewController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 04.07.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var menuController: UIViewController?
    private let button = UIButton(type: .system)
    private var isExpanded = false
    let controller = RouterDestination.cards(nil).constructModule(in: Containers.viewControllers.container)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards()
        view.addSubview(button)
        button.snp.makeConstraints({
            $0.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.size.equalTo(40)
        })
        button.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        button.setImage(R.image.icons.hambMenu(), for: .normal)
    }
    
    
    private func cards() {
        
        
        view.addSubview(controller!.view)
        
        addChild(controller!)
        controller!.didMove(toParent: self)
        
    }
    
    @objc private func menuButtonTapped() {
    
        menu()
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
            
            
            if !self.isExpanded {
                self.controller?.view.frame.origin.x = -self.view.frame.width / 2
                self.isExpanded = true
            } else {
                self.isExpanded = false
                self.controller?.view.frame.origin.x = self.view.frame.origin.x
            }
            
            
        }, completion: { _ in
            
        })
    }
    
    private func menu() {
        if menuController == nil {
            menuController = UIViewController()
            menuController?.view.backgroundColor = .black
            view.insertSubview(menuController!.view, at: 0)
            addChild(menuController!)
            menuController?.didMove(toParent: self)
        }
    }
    
}
