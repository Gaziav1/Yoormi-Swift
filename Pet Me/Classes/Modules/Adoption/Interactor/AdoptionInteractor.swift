//
//  AdoptionAdoptionInteractor.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class AdoptionInteractor: AdoptionInteractorInput {

    private let disposeBag = DisposeBag()
    
    weak var output: AdoptionInteractorOutput!
    var provider: MoyaProvider<YoormiTarget>!
    
    
    func fetchAds() {
        provider.requestArray(.getAds, AnimalAd.self).subscribe({ [weak self] result in
            switch result {
            case .next(let animalAds):
                self?.output.animalAdsFetchSuccess(animalAds)
            case .error(let error as ProviderError):
                self?.output.showError(error.message, error.description)
            default:
                ()
            }
        }).disposed(by: disposeBag)
    }
    

}
