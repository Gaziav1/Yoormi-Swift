//
//  CreateAdCreateAdConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit
import Moya

class CreateAdModuleConfigurator {
    
    static let tag = "CreateAd"

    var appRouter: AppRouterProtocol!
    var moyaProvider: MoyaProvider<YoormiTarget>!
    
    func configure() -> UIViewController {

        let router = CreateAdRouter()
        let controller = CreateAdViewController()
        let presenter = CreateAdPresenter()
        presenter.view = controller
        presenter.router = router
        router.appRouter = appRouter

        let interactor = CreateAdInteractor()
        interactor.output = presenter
        interactor.moyaProvider = moyaProvider
        
        presenter.interactor = interactor
        controller.output = presenter
        
        return controller
    }

}
