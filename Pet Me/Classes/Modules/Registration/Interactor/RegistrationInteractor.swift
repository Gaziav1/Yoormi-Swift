//
//  RegistrationRegistrationInteractor.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Moya
import RxSwift

class RegistrationInteractor {
    
    private let disposeBag = DisposeBag()
    
    weak var output: RegistrationInteractorOutput!
    var firebaseStrategy: FirebaseSrategiesProtocol!
    var firebaseAuthManager: AuthManager!
    var authTokenManager: AuthTokenManagerProtocol!
    var provider: MoyaProvider<YoormiTarget>!
    
}

//MARK: - RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {
    
    func authorizateUser(throughPhone phone: String) {
        provider
            .requestModel(.phoneSignUp(phone: phone), Phone.self)
            .subscribe({ [weak self] response in
                switch response {
                case .next:
                    self?.output.phoneWillRecieveCode()
                case .error(let error as ProviderError):
                    self?.output.phoneWillNotRecieveCode()
                default: ()
                }
            }).disposed(by: disposeBag)
    }
    
    func confirmUser(phone: String, withCode code: String) {
        provider
            .requestModel(.phoneCodeCofirmation(code: code, phone: phone), PhoneAuthTokenResponse.self)
            .subscribe({ response in
                switch response {
                case .next(let response):
                    self.authTokenManager.setJWT(token: response.token)
                    self.output.confirmationDidSuccess(user: response.user)
                case .error(let error as ProviderError):
                    self.output.confirmationDidFail(withError: error)
                default: ()
                }
            }).disposed(by: disposeBag)
    }
}
