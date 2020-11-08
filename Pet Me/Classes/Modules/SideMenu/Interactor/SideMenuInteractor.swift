//
//  SideMenuSideMenuInteractor.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class SideMenuInteractor  {

    weak var output: SideMenuInteractorOutput!
    var authTokenManager: AuthTokenManagerProtocol!

}


//MARK: - SideMenuInteractorInput

extension SideMenuInteractor: SideMenuInteractorInput {
    func checkForAuthorization() {
        authTokenManager.isAuthenticated() ? output.defineItemsForAuthUser() : output.defineItemsForNotAuthUser()
    }
}
