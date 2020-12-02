//
//  AuthTokenManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 05.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import KeychainAccess
import RxSwift

protocol AuthTokenManagerProtocol {
    
    var authStatusObservable: Observable<Bool> { get }
    var apiToken: String? { get }

    func setJWT(token: String)
    func deleteJWT()
}



class AuthTokenManager: AuthTokenManagerProtocol {
    
    private let keychain: Keychain
    private let bearerTokenKey = "BearerTokenKey"
    private let authSubject = PublishSubject<Bool>()
    
    var authStatusObservable: Observable<Bool> {
        return UserDefaults.standard.rx.observe(Bool.self, bearerTokenKey).compactMap({ $0 })
    }
    
    var apiToken: String? {
        return keychain[bearerTokenKey]
    }
    
    init(keychain: Keychain = Keychain()) {
        self.keychain = keychain
        
    }
    
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.bool(forKey: bearerTokenKey)
    }
    
    func setJWT(token: String) {
        log.debug("Saving JWT Token - \(token)")
        
        keychain[bearerTokenKey] = token
 
        UserDefaults.standard.setValue(true, forKey: bearerTokenKey)
    }
    
    func deleteJWT() {
        log.debug("Removing jwt")
        keychain[bearerTokenKey] = nil
        
        UserDefaults.standard.setValue(false, forKey: bearerTokenKey)
    }
}
