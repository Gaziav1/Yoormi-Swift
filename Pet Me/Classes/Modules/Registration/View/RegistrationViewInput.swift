//
//  RegistrationRegistrationViewInput.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol RegistrationViewInput: class {
    func showTextFieldForCode()
    func showError(header: String, body: String)
    func setupInitialState()
}
