//
//  AdoptionAdoptionPresenter.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class AdoptionPresenter: AdoptionModuleInput, AdoptionViewOutput, AdoptionInteractorOutput {

    weak var view: AdoptionViewInput!
    var interactor: AdoptionInteractorInput!
    var router: AdoptionRouterInput!

    func viewIsReady() {

    }
}
