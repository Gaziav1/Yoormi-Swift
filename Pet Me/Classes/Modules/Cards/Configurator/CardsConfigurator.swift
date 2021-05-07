//
//  CardsCardsConfigurator.swift
//  Yoormi
//
//  Created by Gaziav on 28/04/2021.
//  Copyright © 2021 Gaziav. All rights reserved.
//

import UIKit
import Moya

class CardsModuleConfigurator {
    
    static let tag = "CardsModule"
    
    var appRouter: AppRouterProtocol!
    var provider: MoyaProvider<YoormiTarget>!

    func configure() -> UIViewController {

        let router = CardsRouter()
        let viewController = CardsViewController()
        let presenter = CardsPresenter()
        
        presenter.view = viewController
        presenter.router = router

        let interactor = CardsInteractor()
        interactor.output = presenter
        interactor.provider = provider

        router.appRouter = appRouter
        
        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
