//
//  FirebaseProtocols.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase

protocol AuthManager {
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func register(throughCredential credential: OAuthCredential, completion: @escaping (Result<User, Error>) -> Void)
}

protocol StorageManager {
    func fetchUsers(completion: @escaping (Result<[AppUser], Error>) -> Void)
    func fetchSwipes(completion: @escaping (Result<[String: Any]?, Error>) -> Void)
    func saveSwipeToFirestore(userID: String, didLike: Int, completion: @escaping (Error?) -> Void)
    func checkIfMatchExists(userID: String, completion: @escaping (String, String) -> Void)
    func saveMatches(currentUser: AppUser, matchedUser: AppUser)
}

protocol FirebaseManagerProtocol: AuthManager, StorageManager { }



//MARK: AuthManager Protocol Extension

extension AuthManager {
    func registerUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        log.verbose("User registration started")
    
            
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                log.error("Register user error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
    
            //completion(.success(result!.user))
            log.verbose("User \(result!.user.uid) successfully registrated")
        }
    }
        
    
    func register(throughCredential credential: OAuthCredential, completion: @escaping (Result<User, Error>) -> Void) {
        log.verbose("User registretion through credential initiated")
        
        Auth.auth().signIn(with: credential) { (result, error) in
            guard error == nil else {
                log.error("Register user error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return 
            }
            
            //completion(.success(result!.user))
            log.verbose("User registration through credential succeeded - \(result!.user.uid)")
        }
    }
}

