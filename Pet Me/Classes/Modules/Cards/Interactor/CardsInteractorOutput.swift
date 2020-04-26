//
//  CardsCardsInteractorOutput.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol CardsInteractorOutput: class {
    func fetchUsersSuccess(users: [AppUser])
    func fetchUsersFailure()
    func fetchSwipesFailure()
    func fetchSwipesSuccess(swipes: [String: Any]?)
    func matchBetweenUsersExists(currentUserID: String, matchedUserID: String)
}
