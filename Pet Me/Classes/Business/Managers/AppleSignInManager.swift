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

protocol AppleSignInDelegate: class {
    func signInCompleted()
    func signInError(error: Error)
}

protocol AppleSignInManagerProtocol {
    func set(delegate: AppleSignInDelegate)
    func startSignInWithAppleFlow(presentationAnchor: ASPresentationAnchor)
}

class AppleSignInManager: NSObject, AppleSignInManagerProtocol {
    weak var delegate: AppleSignInDelegate?
    private let secureNonceGenerator: SecureNonceGeneratorProtocol
    private let authorizationManager: AuthManager
    private var currentNonce: String?
    private var presentationAnchor: ASPresentationAnchor = UIWindow()
    
    init(nonceGenerator: SecureNonceGeneratorProtocol, authManager: AuthManager) {
        self.secureNonceGenerator = nonceGenerator
        self.authorizationManager = authManager
    }
    
    
    func set(delegate: AppleSignInDelegate) {
        self.delegate = delegate
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
          
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
         
            
            authorizationManager.register(throughCredential: credential) { [unowned self] (result) in
                switch result {
                case .success(let user):
                    self.delegate?.signInCompleted()
                case .failure(let error):
                    self.delegate?.signInError(error: error)
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        log.error("Sign in with Apple failed: \(error.localizedDescription)")
        delegate?.signInError(error: error)
    }
}


extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return presentationAnchor
    }
}
