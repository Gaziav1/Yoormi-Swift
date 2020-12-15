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
    
    func handlePhoneAuth(withData data: [String: String]) {
        
        guard let phone = data["phone"] else { return }
       
        if let code = data["code"] {
            interactor.confirmUser(phone: phone, withCode: code)
        } else {
            interactor.authorizateUser(throughPhone: phone)
        }
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
    func confirmationDidSuccess(user: User) {
        user.name == nil ? router.performTransitionToImageAndName() : router.performTransitionToAds(user: user)
    }
    
    func confirmationDidFail(withError: ProviderError) {
        #warning("Обработай ошибку")
        view.showTextFieldForCode()
    }
    
    func phoneWillRecieveCode() {
        view.showTextFieldForCode()
    }
    
    func phoneWillNotRecieveCode() {
        #warning("Обработай ошибку")
        view.showPhoneError()
    }
}
