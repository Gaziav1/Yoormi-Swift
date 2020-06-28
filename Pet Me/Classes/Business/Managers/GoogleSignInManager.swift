//
//  GoogleSignInManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 24.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

protocol GoogleSignInDelegate: class {
    func signInSuccess()
    func signInFailure(error: Error)
}

protocol GoogleSignInProtocol {
    func signIn()
    func set(delegate: GoogleSignInDelegate)
}

class GoogleSignInManager: NSObject, GoogleSignInProtocol, GIDSignInDelegate {

    weak var delegate: GoogleSignInDelegate?
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
        super.init()
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func signIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func set(delegate: GoogleSignInDelegate) {
        self.delegate = delegate
    }
    
    private func signInWithGoogleFlow(user: GIDGoogleUser?, error: Error?) {
        if let error = error {
            log.error("Google sign in error - \(error)")
            delegate?.signInFailure(error: error)
            return
        }
        
        guard let authentication = user?.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
            guard error == nil else {
                log.error("Google sign in firebase error - \(error!.localizedDescription)")
                return
            }
            
            log.verbose("Google sign in firebase successfully")
            self.delegate?.signInSuccess()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        signInWithGoogleFlow(user: user, error: error)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

