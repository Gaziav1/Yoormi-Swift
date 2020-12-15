//
//  FirebaseUsersFetcher.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase

class FirebaseUsersFetcher: FirebaseSrategiesProtocol {

    static let tag = "UsersFetcher"
    
    
    func uploadData(data: [String: Any], completion: @escaping (Error?) -> Void) {
        
        guard let uid = data["uid"] as? String else {
            log.verbose("Wrong data format")
            return
        }
        
        Firestore.firestore().collection("users").document(uid).setData(data) { (error) in
            if let error = error {
                log.warning("Error occured saving data to database - \(error.localizedDescription)")
                completion(error)
                return
            }
            log.verbose("Data saved")
        }
    }
    
    func fetchData(completion: @escaping (Result<[Codable], Error>) -> Void) {
//        log.info("Starting users fetching...")
//        
//        let query = Firestore.firestore().collection("users")
//        query.getDocuments { (snapshot, error) in
//            if let error = error {
//                log.warning("Error occured with users fetching from Firestore - : \(error.localizedDescription)")
//                completion(.failure(error))
//                return
//            }
//            
//            log.info("Successfully fetched \(snapshot?.count ?? 0) users from firestore")
//            
//            var appUsersArray = [AppUser]()
//            
//            snapshot?.documents.forEach({ (document) in
//                let appUser = AppUser(JSON: document.data())
//                
//                if appUser?.uid != Auth.auth().currentUser?.uid { appUsersArray.append(appUser!) }
//            })
//            
//            completion(.success(appUsersArray))
//        }
    }
    
}
