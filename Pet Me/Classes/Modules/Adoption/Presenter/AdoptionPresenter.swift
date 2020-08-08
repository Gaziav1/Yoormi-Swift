//
//  AdoptionAdoptionPresenter.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class AdoptionPresenter: AdoptionModuleInput {

    weak var view: AdoptionViewInput!
    var interactor: AdoptionInteractorInput!
    var router: AdoptionRouterInput!

    
}


//MARK: -AdoptionViewOutput
extension AdoptionPresenter: AdoptionViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func presentSideMenu() {
        router.presentSideMenu()
    }
    
    func didSelectItem(atIndex index: Int) {
        router.openDetailAdoption()
    }
}

//MARK: -AdoptionInteractorOutput
extension AdoptionPresenter: AdoptionInteractorOutput {
    
}
