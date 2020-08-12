//
//  MyAdsMyAdsRouter.swift
//  PetMe
//
//  Created by Gaziav on 10/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class MyAdsRouter: MyAdsRouterInput {
    
    var appRouter: AppRouterProtocol!
    
    func openSideMenu() {
        appRouter.openSideMenu()
    }
    
    func transitionToCreateAd() {
        appRouter.performTransitionTo(to: .createAd)
    }
}
