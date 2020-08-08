//
//  AdoptionDetailAdoptionDetailPresenter.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class AdoptionDetailPresenter: AdoptionDetailModuleInput, AdoptionDetailInteractorOutput {
    
    weak var view: AdoptionDetailViewInput!
    var interactor: AdoptionDetailInteractorInput!
    var router: AdoptionDetailRouterInput!
    
    
}

extension AdoptionDetailPresenter: AdoptionDetailViewOutput {
    
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
}
