//
//  RegistrationRegistrationPresenter.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class RegistrationPresenter: RegistrationModuleInput {
    
    //MARK: - Viper dependencies
    weak var view: RegistrationViewInput!
    var interactor: RegistrationInteractorInput!
    var router: RegistrationRouterInput!
        
    //MARK: - Private properties
    private var currentUserPhoneNumber = ""
}

//MARK: - RegistrationViewOutput
extension RegistrationPresenter: RegistrationViewOutput {

    func confirm(code: String) {
        interactor.confirmUser(phone: currentUserPhoneNumber, withCode: code)
    }

    func handlePhoneAuth(withPhone phone: String) {
        currentUserPhoneNumber = phone
        interactor.authorizateUser(throughPhone: phone)
    }
    
    func openSideMenu() {
        router.openSideMenu()
    }

    func viewIsReady() {
        view.setupInitialState()
    }
}

//MARK: - RegistrationInteractorOutput
extension RegistrationPresenter: RegistrationInteractorOutput {
   
    func didRecieveError(_ providerError: ProviderError) {
        view.showError(header: providerError.title, body: providerError.message)
    }
    
    func confirmationDidSuccess(user: User) {
        user.name == nil ? router.performTransitionToImageAndName() : router.performTransitionToAds(user: user)
    }
    
    func phoneWillRecieveCode() {
        view.showTextFieldForCode()
    }
}
