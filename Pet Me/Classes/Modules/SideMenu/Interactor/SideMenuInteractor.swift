//
//  SideMenuSideMenuInteractor.swift
//  PetMe
//
//  Created by Gaziav on 04/07/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import RxSwift

class SideMenuInteractor  {
    
    weak var output: SideMenuInteractorOutput!
    var authTokenManager: AuthTokenManagerProtocol!
    private let disposeBag = DisposeBag()
}


//MARK: - SideMenuInteractorInput

extension SideMenuInteractor: SideMenuInteractorInput {
 
    func createAuthSubscription() {
        authTokenManager.authStatusObservable.subscribe(onNext: { authStatus in
            guard let status = authStatus else {
                self.output.defineItemsForNotAuthUser()
                return
            }
            status ? self.output.defineItemsForAuthUser() : self.output.defineItemsForNotAuthUser()
        }).disposed(by: disposeBag)
    }
}
