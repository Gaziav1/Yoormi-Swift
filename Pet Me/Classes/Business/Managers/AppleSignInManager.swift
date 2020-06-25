//
//  AppleSignInManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase
import AuthenticationServices

protocol AppleSignInManagerProtocol {
    func startSignInWithAppleFlow(presentationAnchor: ASPresentationAnchor)
}

class AppleSignInManager: NSObject, AppleSignInManagerProtocol {
    
    private let secureNonceGenerator: SecureNonceGeneratorProtocol
    private let authorizationManager: AuthManager
    private var currentNonce: String?
    private var presentationAnchor: ASPresentationAnchor = UIWindow()
    
    init(nonceGenerator: SecureNonceGeneratorProtocol, authManager: AuthManager) {
        self.secureNonceGenerator = nonceGenerator
        self.authorizationManager = authManager
    }
    
    
    func startSignInWithAppleFlow(presentationAnchor: ASPresentationAnchor) {
        self.presentationAnchor = presentationAnchor
        log.verbose("Apple sign in started")
        let nonce = secureNonceGenerator.randomNonceString(length: 32)
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = secureNonceGenerator.sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                log.warning("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                log.warning("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    log.error("Error occured trying to sign in apple user through firebase - \(error?.localizedDescription)")
    
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    return
                }
                log.verbose("Sign in through apple completed successfully")
                // User is signed in to Firebase with Apple.
                // ...
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        log.error("Sign in with Apple failed: \(error.localizedDescription)")
    }
}


extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchor
    }
}
