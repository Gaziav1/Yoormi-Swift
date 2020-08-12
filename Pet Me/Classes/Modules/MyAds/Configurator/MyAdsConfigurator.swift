//
//  MyAdsMyAdsConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 10/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class MyAdsModuleConfigurator {

    static let tag = "MyAds"
    
    
    var appRouter: AppRouterProtocol!
    
    func configure() -> UIViewController {

        let router = MyAdsRouter()
        let viewController = MyAdsViewController()
        let presenter = MyAdsPresenter()
        
        router.appRouter = appRouter
        presenter.view = viewController
        presenter.router = router

        let interactor = MyAdsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
