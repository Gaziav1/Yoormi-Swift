//
//  AdoptionAdoptionConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import Moya

class AdoptionModuleConfigurator {
    
    static let tag = "Adoption"
    
    var appRouter: AppRouterProtocol!
    var provider: MoyaProvider<YoormiTarget>!
    
    func configure() -> UIViewController {
        
        let viewController = AdoptionViewController()
        let router = AdoptionRouter()
        let presenter = AdoptionPresenter()
        
        router.appRouter = appRouter
        
        presenter.view = viewController
        presenter.router = router
        
        
        let interactor = AdoptionInteractor()
        interactor.output = presenter
        interactor.provider = provider
        
        presenter.interactor = interactor
       
        viewController.output = presenter
        
        return viewController
    }

}
