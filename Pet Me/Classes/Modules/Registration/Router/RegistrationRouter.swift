//
//  RegistrationRegistrationRouter.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class RegistrationRouter: RegistrationRouterInput {
   
    var appRouter: AppRouterProtocol!
    
    
    func openSideMenu() {
        appRouter.openSideMenu()
    }
    
    func performTransitionToImageAndName() {
        appRouter.performTransitionTo(to: .imageAndName)
    }
    
    func performTransitionToAds(user: User) {
        appRouter.changeSideMenuRoot(to: .adoption)
    }
    
}
