//
//  CreateAdCreateAdPresenter.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class CreateAdPresenter: CreateAdModuleInput {

    weak var view: CreateAdViewInput!
    var interactor: CreateAdInteractorInput!
    var router: CreateAdRouterInput!
    var adRequestBuilder: AnimalAdRequestModelBuildable!
}



//MARK: - CreateAdViewOutput
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
    
    func saveFirstStepUserInfo(_ info: FirstStepAdInfo) {
        adRequestBuilder
            .setName(info.animalName)
            .setAge(10)
            .setGender(info.animalGender)
            .setAnimalType(info.animalType)
            .setAnimalSubtype(info.animalSubtype)
            .done()
    }
    
    func saveSecondStepUserInfo(_ info: SecondStepCellInfo) {
        adRequestBuilder
            .setText(info.description)
            .setImages(info.images)
            .done()
    }
    
    
}


//MARK: - CreateAdInteractorOutput
extension CreateAdPresenter: CreateAdInteractorOutput {
    func fetchSubtypesSuccess(_ subtypes: [AnimalSubtypes]) {
        let animalSubtypeCellItems = subtypes.map({ AnimalSubtypeCellItem($0) })
        view.showAnimalSubtypes(animalSubtypeCellItems)
    }
    
    func showError(_ error: ProviderError) {
        view.showError(error.localizedDescription)
    }
}
