//
//  SideMenuSideMenuConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class SideMenuModuleConfigurator {

    static let tag = "SideMenu"
    
    func configure() -> UIViewController {

        let router = SideMenuRouter()
        let viewController = SideMenuViewController()
        let presenter = SideMenuPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SideMenuInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}