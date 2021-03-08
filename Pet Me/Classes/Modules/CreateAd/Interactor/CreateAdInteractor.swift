//
//  CreateAdCreateAdInteractor.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Moya

class CreateAdInteractor: CreateAdInteractorInput {

    weak var output: CreateAdInteractorOutput!
    var moyaProvider: MoyaProvider<YoormiTarget>!
    
    func fetchAnimalSubtypes(forAnimalType type: AnimalTypes) {
        moyaProvider
            .requestModel(.animalSubtypes(type), AnimalSubtypes.self)
            .subscribe({ [weak self] result in
                switch result {
                case .next(let animalSubtypes):
                    print(animalSubtypes)
                case .error(let error as ProviderError):
                    print(error.localizedDescription)
                default: ()
                }
            })
        
    }
}
