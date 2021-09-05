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
        interactor.fetchAds()
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
    func animalAdsFetchSuccess(_ animalAds: [AnimalAd]) {
        view.showAds(animalAds)
    }
    
    func showError(_ message: String, _ description: String) {
        view.showError(message, description)
    }
}
