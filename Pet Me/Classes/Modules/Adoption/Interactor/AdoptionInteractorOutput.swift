//
//  AdoptionAdoptionInteractorOutput.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol AdoptionInteractorOutput: AnyObject {
    func animalAdsFetchSuccess(_ animalAds: [AnimalAd])
    func showError(_ message: String, _ description: String)
}
