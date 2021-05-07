//
//  CardsCardsPresenter.swift
//  Yoormi
//
//  Created by Gaziav on 28/04/2021.
//  Copyright © 2021 Gaziav. All rights reserved.
//

class CardsPresenter: CardsModuleInput, CardsViewOutput {

    weak var view: CardsViewInput!
    var interactor: CardsInteractorInput!
    var router: CardsRouterInput!

    func viewIsReady() {
        interactor.fetchADs()
    }
}

extension CardsPresenter: CardsInteractorOutput {
    func showError(_ providerError: ProviderError) {
        view.showError(providerError.title, providerError.message)
    }
    
    func adsFetchDidSuccess(_ animalAd: [AnimalAd]) {
        //Convert animalAds to items
    }
}
