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
    
    var appRouter: AppRouterProtocol!
    var authTokenManager: AuthTokenManagerProtocol!
    
    func configure() -> UIViewController {

        let router = SideMenuRouter()
        let viewController = SideMenuViewController()
        let presenter = SideMenuPresenter()
        
        router.appRouter = appRouter
        presenter.view = viewController
        presenter.router = router
        
        let interactor = SideMenuInteractor()
        interactor.output = presenter
        interactor.authTokenManager = authTokenManager
        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
