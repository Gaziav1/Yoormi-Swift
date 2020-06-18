//
//  FirebaseManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase


class FirebaseManager: FirebaseManagerProtocol {
    
    var uid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    var isAuthenticated: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func fetchUsers(completion: @escaping (Result<[AppUser], Error>) -> Void) {
        log.info("Starting users fetching...")
        
        let query = Firestore.firestore().collection("users")
        query.getDocuments { (snapshot, error) in
            if let error = error {
                log.warning("Error occured with users fetching from Firestore - : \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            log.info("Successfully fetched \(snapshot?.count ?? 0) users from firestore")
            
            var appUsersArray = [AppUser]()
            
            snapshot?.documents.forEach({ (document) in
                
                let user = AppUser(dictionary: document.data())
                let isCurrentUser = user.uid == self.uid
                if !isCurrentUser {
                    appUsersArray.append(user)
                }
            })
            
            completion(.success(appUsersArray))
        }
    }
    
    func fetchSwipes(completion: @escaping (Result<[String: Any]?, Error>) -> Void) {
        guard let currentUserId = uid else { return }
        log.info("Starting swipes fetching...")
        
        Firestore.firestore().collection("swipes").document(currentUserId).getDocument { (snapshot, error) in
            if let err = error {
                log.warning("Error occured with swipes fetching for user - \(currentUserId)")
                completion(.failure(err))
                return
            }
            
            
            completion(.success(snapshot?.data()))
            log.info("Completed swipes fetching")
            
        }
    }
    
    func saveSwipeToFirestore(userID: String, didLike: Int, completion: @escaping (Error?) -> Void) {
        
        log.info("Trying to save swipe with user id - \(userID) to Firestore...")
        guard let currentUserID = uid else { return }
        let documentData = [userID: didLike]
        
        Firestore.firestore().collection("swipes").document(currentUserID).getDocument { (snapshot, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(error)
            }
            
            // If data exists updating it, else setting new data
    
            if snapshot?.exists == true {
                Firestore.firestore().collection("swipes").document(currentUserID).updateData(documentData) { (error) in
                    if error != nil {
                        log.warning("Failed to update swipes")
                        completion(error)
                        return
                    }
                    log.info("Swipes of user \(currentUserID) has been updated")
                    
                    //If didLike == 1 user liked other user, so we need to check if match between them exists
                    
                    if didLike == 1 {
                        completion(nil)
                    }
                }
                
            } else {
                
                Firestore.firestore().collection("swipes").document(currentUserID).setData(documentData) { (error) in
                    if error != nil {
                        log.warning("Failed to set swipes")
                        completion(error)
                        return
                    }
                    
                    log.info("Swipes for user \(currentUserID) successfully set")
        
                    if didLike == 1 {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func checkIfMatchExists(userID: String, completion: @escaping (String, String) -> Void) {
        guard let currentUserID = uid else { return }
        log.info("Checking for matches with user - \(userID)")
        
        Firestore.firestore().collection("swipes").document(userID).getDocument { (snapshot, error) in
            if error != nil {
                log.warning("Error occured fetching swipes for user \(userID)")
                return
            }
            
            guard let data = snapshot?.data(), let currentUserLikeStatus = data[currentUserID] as? Int else {
                log.info("Match do not exist")
                return
            }
            
            let hasMatched = currentUserLikeStatus == 1
            
            log.info("Matches for user \(userID) successfully fetched")
            
            if hasMatched {
                completion(currentUserID, userID)
            }
        }
    }
    
    func saveMatches(currentUser: AppUser, matchedUser: AppUser) {
        guard let currentUserID = uid else { return }
        log.info("Saving match between users...")
        
        Firestore.firestore().collection("matches_messages").document(currentUserID).collection("matches").document(matchedUser.uid).setData(["name": matchedUser.name ?? "No name", "imageURL": matchedUser.imageNames[0], "uid": matchedUser.uid, "date": Timestamp(date: Date())])
        
        Firestore.firestore().collection("matches_messages").document(matchedUser.uid).collection("matches").document(currentUserID).setData(["name": currentUser.name ?? "No name", "imageURL": currentUser.imageNames[0], "uid": currentUserID, "date": Timestamp(date: Date())])
    }
}

