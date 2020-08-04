//
//  StartingStartingConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class StartingModuleConfigurator {
    
    static let tag = "StartingTag"
    var appleSignInManager: AppleSignInManagerProtocol!
    var firebaseStrategy: FirebaseSrategiesProtocol!
    var googleSignInManager: GoogleSignInProtocol!
    var appRouter: AppRouterProtocol!

    func configure() -> UIViewController {
    
        let router = StartingRouter()
        let viewController = StartingViewController()
        let presenter = StartingPresenter()
        router.appRouter = appRouter
        presenter.view = viewController
        presenter.router = router

        let interactor = StartingInteractor()
        interactor.output = presenter
        interactor.appleSignInManager = appleSignInManager
        interactor.googleSignInManager = googleSignInManager
        interactor.firebaseStrategy = firebaseStrategy
        
        appleSignInManager.set(delegate: interactor)
        googleSignInManager.set(delegate: interactor)
        
        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
