//
//  RegistrationRegistrationInteractor.swift
//  PetMe
//
//  Created by Gaziav on 19/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class RegistrationInteractor {

    
    weak var output: RegistrationInteractorOutput!
    var firebaseStrategy: FirebaseSrategiesProtocol!
    var firebaseAuthManager: AuthManager!
}

//MARK: -RegistrationInteractorInput
extension RegistrationInteractor: RegistrationInteractorInput {
    
    func authorizateUser(email: String, password: String) {
        firebaseAuthManager.registerUser(email: email, password: password) { [unowned self] (result) in
            
            switch result {
            case .success(let user):
                self.output.registrationSuccess()
                let userData: [String: Any] = ["uid": user.uid,
                                "name": "",
                                "imageURL": ""]
                self.firebaseStrategy.uploadData(data: userData) { (error) in
                    print(error?.localizedDescription)
                }
            case .failure(_):
                self.output.registrationFailure()
            }
            
        }
    }
}
