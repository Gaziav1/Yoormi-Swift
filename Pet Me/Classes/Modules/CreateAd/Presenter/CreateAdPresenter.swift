//
//  CreateAdCreateAdPresenter.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import CoreLocation

class CreateAdPresenter: CreateAdModuleInput {

    weak var view: CreateAdViewInput!
    var interactor: CreateAdInteractorInput!
    var router: CreateAdRouterInput!
    var adRequestBuilder: AnimalAdRequestModelBuildable!
}



//MARK: - CreateAdViewOutput
extension CreateAdPresenter: CreateAdViewOutput {
    

    func createAdRequestModel() {
        do {
            let adRequestModel = try adRequestBuilder.build()
            interactor.saveRequestModel(adRequestModel)
        } catch let error {
            print(error)
        }
    }
    
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
        #warning("Price and age are hardcoded for now")
        adRequestBuilder
            .setName(info.animalName)
            .setAge(10)
            .setGender(info.animalGender)
            .setAnimalType(info.animalType)
            .setAnimalSubtype(info.animalSubtype)
            .setPrice(22)
            .done()
    }
    
    func saveSecondStepUserInfo(_ info: SecondStepCellInfo) {
        adRequestBuilder
            .setText(info.description)
            .setImages(info.images)
            .done()
    }
    
    func requestLocation() {
        interactor.requestUserLocation()
    }
}


//MARK: - CreateAdInteractorOutput
extension CreateAdPresenter: CreateAdInteractorOutput {
    
    
    func requestForLocationSucceeded(_ location: String, _ coordinate: CLLocationCoordinate2D) {
        adRequestBuilder.setAddress(coordinate).done()
        view.showLocationString(location)
    }
    
    func requestForLocationFailed() {
        #warning("Change this later")
        view.showError("Request for location failed")
    }
    
    func fetchSubtypesSuccess(_ subtypes: [AnimalSubtypes]) {
        let animalSubtypeCellItems = subtypes.map({ AnimalSubtypeCellItem($0) })
        view.showAnimalSubtypes(animalSubtypeCellItems)
    }
    
    func showError(_ error: ProviderError) {
        view.showError(error.localizedDescription)
    }
}
