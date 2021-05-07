//
//  CardsCardsInteractor.swift
//  Yoormi
//
//  Created by Gaziav on 28/04/2021.
//  Copyright © 2021 Gaziav. All rights reserved.
//

import Moya
import RxSwift

class CardsInteractor: CardsInteractorInput {

    private let disposeBag = DisposeBag()
    
    weak var output: CardsInteractorOutput!
    var provider: MoyaProvider<YoormiTarget>!
    
    
    func fetchADs() {
        provider.requestArray(.getAds, AnimalAd.self).subscribe({ [weak self] result in
            switch result {
            case .next(let ads):
                self?.output.adsFetchDidSuccess(ads)
            case .error(let error as ProviderError):
                self?.output.showError(error)
            default: ()
            }
        }).disposed(by: disposeBag)
    }
}
