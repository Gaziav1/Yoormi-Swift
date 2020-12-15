//
//  ImageAndNameImageAndNameConfigurator.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

import UIKit

class ImageAndNameModuleConfigurator {

    static let tag = "ImageAndName"
    
    var appRouter: AppRouterProtocol!

    func configure() -> UIViewController {

        let router = ImageAndNameRouter()
        let viewController = ImageAndNameViewController()
        let presenter = ImageAndNamePresenter()
        presenter.view = viewController
        router.appRouter = appRouter
        presenter.router = router

        let interactor = ImageAndNameInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
