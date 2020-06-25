//
//  StartingStartingInteractor.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//
import AuthenticationServices

class StartingInteractor {

    weak var output: StartingInteractorOutput!
    var appleSignInManager: AppleSignInManagerProtocol!
}

//MARK: -StartingInteractorInput
extension StartingInteractor: StartingInteractorInput {
    func initiateSignInWithApple(inAnchor anchor: ASPresentationAnchor) {
        appleSignInManager.startSignInWithAppleFlow(presentationAnchor: anchor)
    }
}
