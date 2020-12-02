//
//  RegistrationRegistrationRouterInput.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol RegistrationRouterInput {
    func openSideMenu()
    func performTransitionToImageAndName()
    func performTransitionToAds(user: User)
}
