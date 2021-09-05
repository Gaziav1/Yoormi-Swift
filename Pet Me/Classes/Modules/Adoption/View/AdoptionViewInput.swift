//
//  AdoptionAdoptionViewInput.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol AdoptionViewInput: class {

    /**
        @author Gaziav
        Setup initial state of the view
    */

    func setupInitialState()
    func showAds(_ ads: [AnimalAd])
    func showError(_ title: String, _ message: String)
}
