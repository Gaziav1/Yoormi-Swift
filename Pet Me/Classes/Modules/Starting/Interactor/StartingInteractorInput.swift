//
//  StartingStartingInteractorInput.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import AuthenticationServices

protocol StartingInteractorInput {
    func initiateSignInWithApple(inAnchor anchor: ASPresentationAnchor)
}
