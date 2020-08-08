//
//  CardsCardsPresenter.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

class CardsPresenter: CardsModuleInput, CardsViewOutput, CardsInteractorOutput {
    
    weak var view: CardsViewInput!
    var interactor: CardsInteractorInput!
    var router: CardsRouterInput!
    
    private var user: AppUser?
    
    private var usersData = [String: AppUser]()
    private var swipedUsers: [String: Any]?
    
    
    init(user: AppUser?) {
        self.user = user
    }
    
    
    //MARK: CardsInteractorOutput
    
    func fetchSwipesFailure() {
       // view.hideHUD()
        #warning("Необходимо обработать ошибку")
    }
    
    func fetchSwipesSuccess(swipes: [String : Any]?) {
        self.swipedUsers = swipes
        interactor.fetchUsers()
    }
    
    func fetchUsersFailure() {
       // view.hideHUD()
        #warning("Необходимо обработать ошибку")
    }
    
    func fetchUsersSuccess(users: [AppUser]) {
        users.forEach { (appUser) in
            usersData[appUser.uid] = appUser
            let userNotBeenSwipedBefore = self.swipedUsers?[appUser.uid] == nil
            
            if userNotBeenSwipedBefore {
                view.createCardView(from: appUser)
            }
        }
    }
    
    func matchBetweenUsersExists(currentUserID: String, matchedUserID: String) {
        view.presentMatchView()
        guard let currentUser = usersData[currentUserID], let likedUser = usersData[matchedUserID] else { return }
        interactor.saveMatch(currentUser: currentUser, matchedUser: likedUser)
    }
    
    
    //MARK: CardViewOutput
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetchSwipes()
    }
    
    func viewAppeared() {
        
    }
    
    func saveLike(userID: String) {
        interactor.saveSwipe(swipedUserID: userID, didLike: 1)
        view.handleLike()
    }
    
    func saveDislike(userID: String) {
        interactor.saveSwipe(swipedUserID: userID, didLike: 0)
        view.handleDislike()
    }
    
    func proceedToSettings() {
        router.openSettings()
    }
    
    func proceedToMessages() {
        router.openMessages()
    }
    
    func didTapMenuButton() {
        router.openSideMenu()
    }
}


