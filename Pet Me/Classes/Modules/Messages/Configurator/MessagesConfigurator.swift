//
//  MessagesMessagesConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 23/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class MessagesModuleConfigurator {

    static let tag = "MessagesTag"
    var appRouter: AppRouterProtocol!
    
    func configure() -> UIViewController {

        let router = MessagesRouter()
        let viewController = MessagesViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter = MessagesPresenter()
        
        router.appRouter = appRouter
        presenter.view = viewController
        presenter.router = router

        let interactor = MessagesInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
