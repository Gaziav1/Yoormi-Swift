//
//  CardsCardsRouter.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class CardsRouter: CardsRouterInput {
    func openMessages() {
        AppRouter.shared.performTransitionTo(to: .messages)
    }
    
    func openSettings() {
        AppRouter.shared.performTransitionTo(to: .settings)
    }
}
