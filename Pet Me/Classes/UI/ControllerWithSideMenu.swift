//
//  SideMenuController.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 08.08.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

class ControllerWithSideMenu: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    func sideMenuAction() {
        fatalError("Every sidemenu controlllers have to override this method")
    }
    
    @objc private func rightBarButtonAction() {
        sideMenuAction()
    }
    
    func setupNavigationBar() {
        //override if u want customize navigation bar
        let hambMenuImage = R.image.icons.hambMenu()?.withRenderingMode(.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image: hambMenuImage, style: .plain, target: self, action: #selector(rightBarButtonAction))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
}
