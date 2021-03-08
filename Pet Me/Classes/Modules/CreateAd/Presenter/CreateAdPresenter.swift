//
//  CreateAdCreateAdPresenter.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class CreateAdPresenter: CreateAdModuleInput, CreateAdInteractorOutput {

    weak var view: CreateAdViewInput!
    var interactor: CreateAdInteractorInput!
    var router: CreateAdRouterInput!

    
}

extension CreateAdPresenter: CreateAdViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didSelectRow(withIndex: Int) {
        view.openImageController()
    }
    
    func fetchAnimalSubtype(_ animalType: AnimalTypes) {
        interactor.fetchAnimalSubtypes(forAnimalType: animalType)
    }
}
