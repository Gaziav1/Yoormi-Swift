//
//  CardsCardsRouter.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class CardsRouter: CardsRouterInput {
    
    var appRouter: AppRouterProtocol!
    
    func openMessages() {
        appRouter.performTransitionTo(to: .messages)
    }
    
    func openSettings() {
        appRouter.performTransitionTo(to: .settings)
    }
    
    func openSideMenu() {
        appRouter.openSideMenu()
    }
}
