//
//  MyAdsMyAdsPresenter.swift
//  PetMe
//
//  Created by Gaziav on 10/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class MyAdsPresenter: MyAdsModuleInput, MyAdsInteractorOutput {
    
    weak var view: MyAdsViewInput!
    var interactor: MyAdsInteractorInput!
    var router: MyAdsRouterInput!
    
    private let ads = [""]
}


extension MyAdsPresenter: MyAdsViewOutput {
    func viewIsReady() {
        view.setupInitialState()
        
        ads[0] == "" ? view.presentEmptyView() : view.presentAds(ads: ads)
    }
    
    func didTapMenuButton() {
        router.openSideMenu()
    }
    
    func didTapPlusButton() {
        router.transitionToCreateAd()
    }
}
