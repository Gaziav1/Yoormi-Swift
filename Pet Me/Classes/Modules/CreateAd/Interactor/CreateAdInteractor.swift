//
//  CreateAdCreateAdInteractor.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Moya
import RxSwift

class CreateAdInteractor: CreateAdInteractorInput {
    private let diposeBag = DisposeBag()
    
    weak var output: CreateAdInteractorOutput!
    var moyaProvider: MoyaProvider<YoormiTarget>!
    var locationManager: LocationManagerProtocol! {
        didSet {
            setupSubscriptions()
        }
    }
    
    
    func fetchAnimalSubtypes(forAnimalType type: AnimalTypes) {
        moyaProvider
            .requestArray(.animalSubtypes(type), AnimalSubtypes.self)
            .subscribe({ [weak self] result in
                switch result {
                case .next(let animalSubtypes):
                    self?.output.fetchSubtypesSuccess(animalSubtypes)
                case .error(let error as ProviderError):
                    self?.output.showError(error)
                default: ()
                }
            }).disposed(by: diposeBag)
    }
    
    func requestUserLocation() {
        locationManager.requestUserLocation()
    }
    
    func saveRequestModel(_ adRequestModel: AnimalAdRequestModel) {
        print(adRequestModel)
        moyaProvider
            .requestModel(.createAd(adRequestModel), ServerResponse.self)
            .subscribe({ [weak self] result in
                switch result {
                case .next:
                    print("harray")
                case .error(let error):
                    print(error.localizedDescription)
                default: ()
                }
            }).disposed(by: diposeBag)
    }
    
    private func setupSubscriptions() {
        locationManager.locationChangeObservable.subscribe(onNext: { [weak self] locationItem in
            guard let item = locationItem, let location = item.location else {
                self?.output.requestForLocationFailed()
                print("Failed")
                return
            }
            print(item.locationString)
            self?.output.requestForLocationSucceeded(item.locationString, location.coordinate)
        }).disposed(by: diposeBag)
    }
}

