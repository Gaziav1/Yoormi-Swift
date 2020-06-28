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
    var googleSignInManager: GoogleSignInProtocol!

    func configure() -> UIViewController {
    
        let router = StartingRouter()
        let viewController = StartingViewController()
        let presenter = StartingPresenter()
       
        presenter.view = viewController
        presenter.router = router

        let interactor = StartingInteractor()
        interactor.output = presenter
        interactor.appleSignInManager = appleSignInManager
        interactor.googleSignInManager = googleSignInManager
        
        appleSignInManager.set(delegate: interactor)
        googleSignInManager.set(delegate: interactor)
        
        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
