//
//  RegistrationRegistrationInteractorOutput.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol RegistrationInteractorOutput: class {
    func phoneWillRecieveCode()
    func confirmationDidSuccess(user: User)
    func didRecieveError(_ providerError: ProviderError)
}
