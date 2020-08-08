//
//  CardsCardsInteractor.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

class CardsInteractor: CardsInteractorInput {

    weak var output: CardsInteractorOutput!
    var firebaseManager: FirebaseManagerProtocol!
    
//MARK: CardInteractorInput
    
    
    func fetchSwipes() {
        
        
        firebaseManager.fetchSwipes { (result) in
            switch result {
            case .failure(_):
                self.output.fetchSwipesFailure()
            case .success(let data):
                self.output.fetchSwipesSuccess(swipes: data)
            }
        }
    }
    
    func fetchUsers() {
        firebaseManager.fetchUsers { (result) in
            switch result {
            case .failure(_):
                self.output.fetchUsersFailure()
            case .success(let appUsers):
                self.output.fetchUsersSuccess(users: appUsers)
            }
        }
    }
    
    func saveSwipe(swipedUserID: String, didLike: Int) {
        firebaseManager.saveSwipeToFirestore(userID: swipedUserID, didLike: didLike) { [weak self] (error) in
            guard error == nil else {
                return
            }

            self?.checkIfMatchExists(userID: swipedUserID)
        }
    }
    
    private func checkIfMatchExists(userID: String) {
        firebaseManager.checkIfMatchExists(userID: userID) { [weak self] (currentUserID, matchedUserID) in
            self?.output.matchBetweenUsersExists(currentUserID: currentUserID, matchedUserID: matchedUserID)
        }
    }
    
    func saveMatch(currentUser: AppUser, matchedUser: AppUser) {
        firebaseManager.saveMatches(currentUser: currentUser, matchedUser: matchedUser)
    }
}
