//
//  StartingStartingPresenter.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class StartingPresenter: StartingModuleInput, StartingInteractorOutput {

    weak var view: StartingViewInput!
    var interactor: StartingInteractorInput!
    var router: StartingRouterInput!

    
}


//MARK: -StartingViewOutput
extension StartingPresenter: StartingViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func appleSignInTapped(presentationAnchor: UIWindow) {
        interactor.initiateSignInWithApple(inAnchor: presentationAnchor)
    }
}
