//
//  CardsCardsViewInput.swift
//  Yoormi
//
//  Created by Gaziav on 28/04/2021.
//  Copyright © 2021 Gaziav. All rights reserved.
//

protocol CardsViewInput: class {

    /**
        @author Gaziav
        Setup initial state of the view
    */

    func setupInitialState()
    func showError(_ title: String, _ subTitle: String)
    func getAdCardViewItems(_ items: [CardViewItem])
}
