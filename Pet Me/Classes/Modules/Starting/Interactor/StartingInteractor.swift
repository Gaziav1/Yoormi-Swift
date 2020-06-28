//
//  StartingStartingInteractor.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//
import AuthenticationServices
import GoogleSignIn

class StartingInteractor {

    weak var output: StartingInteractorOutput!
    var appleSignInManager: AppleSignInManagerProtocol!
    var googleSignInManager: GoogleSignInProtocol!
}

//MARK: -StartingInteractorInput
extension StartingInteractor: StartingInteractorInput {
    func initiateSignInWithApple(inAnchor anchor: ASPresentationAnchor) {
        appleSignInManager.startSignInWithAppleFlow(presentationAnchor: anchor)
    }
    
    func initiateSignInWithGoogle() {
        googleSignInManager.signIn()
    }
}

//MARK: -AppleSignInDelegate
extension StartingInteractor: AppleSignInDelegate {
    func signInCompleted() {
        output.signInCompleted()
    }
    
    func signInError(error: Error) {
        output.signInError(error: error)
    }
}

//MARK: -GoogleSignInDelegate
extension StartingInteractor: GoogleSignInDelegate {
    func signInSuccess() {
        output.signInCompleted()
    }
    
    func signInFailure(error: Error) {
        output.signInError(error: error)
    }
}
