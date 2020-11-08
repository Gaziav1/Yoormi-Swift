//
//  AuthTokenManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 05.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import KeychainAccess

protocol AuthTokenManagerProtocol {
    func isAuthenticated() -> Bool
    func setJWT(token: String)
    func deleteJWT()
}



class AuthTokenManager: AuthTokenManagerProtocol {
    
    private let keychain = Keychain()
    private let apiToken: String? = nil
    
    func isAuthenticated() -> Bool {
        return false
    }
    
    func setJWT(token: String) {
        print("hello")
    }
    
    func deleteJWT() {
        print("hello")
    }
}
