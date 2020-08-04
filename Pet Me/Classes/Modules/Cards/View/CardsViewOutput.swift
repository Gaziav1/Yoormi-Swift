//
//  CardsCardsViewOutput.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol CardsViewOutput {

    /**
        @author Gaziav
        Notify presenter that view is ready
    */

    func viewIsReady()
    func proceedToSettings()
    func proceedToMessages()
    func didTapMenuButton()
    func saveDislike(userID: String)
    func saveLike(userID: String)
}
