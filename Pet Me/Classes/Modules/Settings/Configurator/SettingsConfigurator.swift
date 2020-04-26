//
//  SettingsSettingsConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 23/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class SettingsModuleConfigurator {

    static let tag = "SettingsTag"
    
    func configure() -> UIViewController {

        let router = SettingsRouter()
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter()
        
        presenter.view = viewController
        presenter.router = router

        let interactor = SettingsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
        return viewController
    }

}
