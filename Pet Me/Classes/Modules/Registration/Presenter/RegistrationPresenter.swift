//
//  RegistrationRegistrationPresenter.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class RegistrationPresenter: RegistrationModuleInput {

    weak var view: RegistrationViewInput!
    var interactor: RegistrationInteractorInput!
    var router: RegistrationRouterInput!

    
}

//MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {
    
    func handlePhoneAuth(phone: String) {
        interactor.authorizateUser(throughPhone: phone)
    }
    
    func openSideMenu() {
        router.openSideMenu()
    }
    
    func engageAuthorizathion(withEmail email: String, andPassword password: String) {
        interactor.authorizateUser(email: email, password: password)
    }
    
    func viewIsReady() {
        view.setupInitialState()
    }
}

//MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
    func phoneWillRecieveCode() {
        view.showTextFieldForCode()
    }
    
    func phoneWillNotRecieveCode() {
        view.showPhoneError()
    }
    
    func registrationSuccess() {
        print("success")
    }
    
    func registrationFailure() {
        print("failure")
    }
}
