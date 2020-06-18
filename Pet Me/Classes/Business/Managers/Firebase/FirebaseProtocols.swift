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
        log.info("User registration started")
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                log.error("Register user error: \(String(describing: error?.localizedDescription))")
                completion(.failure(error!))
                return
            }
    
            completion(.success(result!.user))
            log.info("User \(result!.user.uid) successfully registrated")
        }
    }
}

