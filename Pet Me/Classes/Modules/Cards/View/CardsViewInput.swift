//
//  CardsCardsViewInput.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol CardsViewInput: class {

    /**
        @author Gaziav
        Setup initial state of the view
    */

    func setupInitialState()
    func hideHUD()
    func handleLike()
    func handleDislike()
    func createCardView(from: AppUser)
    func presentMatchView()
}
