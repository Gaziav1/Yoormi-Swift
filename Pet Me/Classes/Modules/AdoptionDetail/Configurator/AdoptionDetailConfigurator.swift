//
//  AdoptionDetailAdoptionDetailConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class AdoptionDetailModuleConfigurator {
    
    static let tag = "AdoptionDetail"
    
    var appRouter: AppRouterProtocol!

    func configure() -> UIViewController {

        let router = AdoptionDetailRouter()
        let viewController = AdoptionDetailViewController()
        router.appRouter = appRouter
        
        let presenter = AdoptionDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AdoptionDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
