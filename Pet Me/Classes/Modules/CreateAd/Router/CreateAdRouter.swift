//
//  CreateAdCreateAdRouter.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class CreateAdRouter: CreateAdRouterInput {
    var appRouter: AppRouterProtocol!
    
    func proceedToMyAds() {
        #warning("Just dismiss instead of this")
        appRouter.dropAll(to: .myAds)
    }
}
