//
//  AdoptionAdoptionConfigurator.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class AdoptionModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AdoptionViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AdoptionViewController) {

        let router = AdoptionRouter()

        let presenter = AdoptionPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AdoptionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
