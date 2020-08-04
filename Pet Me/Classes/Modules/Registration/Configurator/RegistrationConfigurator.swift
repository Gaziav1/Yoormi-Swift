//
//  RegistrationRegistrationConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class RegistrationModuleConfigurator {

    static let tag = "RegistrationTag"
 
    var firebaseAuthManager: AuthManager!
    var firebaseStrategy: FirebaseSrategiesProtocol!
    var appRouter: AppRouterProtocol!
    
    func configure() -> UIViewController {

        let router = RegistrationRouter()
        let controller = RegistrationViewController()
        let presenter = RegistrationPresenter()
        
        router.appRouter = appRouter
        presenter.view = controller
        presenter.router = router

        let interactor = RegistrationInteractor()
        interactor.firebaseStrategy = firebaseStrategy
        interactor.firebaseAuthManager = firebaseAuthManager
        interactor.output = presenter

        presenter.interactor = interactor
        controller.output = presenter
        
        return controller
    }

}
