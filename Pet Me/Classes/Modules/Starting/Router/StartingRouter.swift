//
//  StartingStartingRouter.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class StartingRouter: StartingRouterInput {
    func proceedToCards(user: AppUser) {
        AppRouter.shared.performTransitionTo(to: .cards(user))
    }
}
