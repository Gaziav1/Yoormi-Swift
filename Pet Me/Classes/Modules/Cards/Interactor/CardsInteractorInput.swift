//
//  CardsCardsInteractorInput.swift
//  PetMe
//
//  Created by Gaziav on 22/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol CardsInteractorInput {
    func fetchUsers()
    func fetchSwipes()
    func saveSwipe(swipedUserID: String, didLike: Int)
    func saveMatch(currentUser: AppUser, matchedUser: AppUser)
}
