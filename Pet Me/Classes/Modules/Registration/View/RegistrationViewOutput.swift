//
//  RegistrationRegistrationViewOutput.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

protocol RegistrationViewOutput {

    func viewIsReady()
    func handlePhoneAuth(withPhone: String)
    func confirm(code: String)
    func openSideMenu()
}
