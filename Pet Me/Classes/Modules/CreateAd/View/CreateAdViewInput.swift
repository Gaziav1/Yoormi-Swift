//
//  CreateAdCreateAdViewInput.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol CreateAdViewInput: class {

    /**
        @author Gaziav
        Setup initial state of the view
    */

    func setupInitialState()
    func openImageController()
    func showError(_ description: String)
    func showLocationString(_ locationString: String)
    func showAnimalSubtypes(_ subtypesItem: [AnimalSubtypeCellItem])
}
