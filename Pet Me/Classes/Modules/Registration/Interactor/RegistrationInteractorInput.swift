//
//  RegistrationRegistrationInteractorInput.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol RegistrationInteractorInput {
  func authorizateUser(throughPhone: String)
  func authorizateUser(email: String, password: String)
  func signInUser(email: String, password: String)
}
