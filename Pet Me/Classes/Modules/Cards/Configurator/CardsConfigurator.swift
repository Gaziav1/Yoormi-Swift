//
//  CardsCardsConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class CardsModuleConfigurator {

   static let tag = "CardTag"
    
   var firebaseManager: FirebaseManagerProtocol!

   func configure() -> UIViewController {

        let router = CardsRouter()
        let viewController = CardsViewController()
        let presenter = CardsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CardsInteractor()
        interactor.output = presenter
        interactor.firebaseManager = firebaseManager
        

        presenter.interactor = interactor
        viewController.output = presenter
    
        return viewController
    }

}
