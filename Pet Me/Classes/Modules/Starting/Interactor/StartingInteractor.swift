//
//  StartingStartingInteractor.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//
import AuthenticationServices
import Firebase
import GoogleSignIn

class StartingInteractor {
    
    weak var output: StartingInteractorOutput!
    var firebaseStrategy: FirebaseSrategiesProtocol!
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
        output.signInCompleted(user: AppUser(JSON: [:])!)
    }
    
    func signInError(error: Error) {
        output.signInError(error: error)
    }
}

//MARK: -GoogleSignInDelegate
extension StartingInteractor: GoogleSignInDelegate {
    func signInSuccess(user: AppUser?) {
        guard let user = user else {
            log.info("Current user == nil")
            return
        }
        
//        firebaseStrategy.uploadData(data: user) { (error) in
//            guard error == nil else {
//                log.warning("Error occured saving current user to firestore")
//                return
//            }
//        }
        
        output.signInCompleted(user: user)
    }
    
    func signInFailure(error: Error) {
        output.signInError(error: error)
    }
}
