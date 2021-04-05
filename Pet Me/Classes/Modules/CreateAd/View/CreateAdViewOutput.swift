//
//  CreateAdCreateAdViewOutput.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol CreateAdViewOutput {

    /**
        @author Gaziav
        Notify presenter that view is ready
    */

    func viewIsReady()
    func fetchAnimalSubtype(_ animalType: AnimalTypes)
    func didSelectRow(withIndex: Int)
    func saveFirstStepUserInfo(_ info: FirstStepAdInfo)
}
