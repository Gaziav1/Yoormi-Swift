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

protocol GoogleSignInProtocol {
    func signInWithGoogleFlow(user: GIDGoogleUser?, error: Error?)
}

class GoogleSignInManager: NSObject, GoogleSignInProtocol {
    
    private let authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    
    
    func signInWithGoogleFlow(user: GIDGoogleUser?, error: Error?) {
        if let error = error {
            log.error("Google sign in error - \(error)")
          return
        }

        guard let authentication = user?.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            guard error == nil else {
                log.error("Google sign in firebase error - \(error!.localizedDescription)")
                return
            }
            
            log.verbose("Google sign in firebase successfully")
            print(result?.additionalUserInfo?.username)
        }
    }
    
    
}

