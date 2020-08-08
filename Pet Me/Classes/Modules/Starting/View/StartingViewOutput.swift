//
//  StartingStartingViewOutput.swift
//  PetMe
//
//  Created by Gaziav on 22/06/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//
import UIKit

protocol StartingViewOutput {

    func viewIsReady()
    func googleSignInTapped()
    func signInWithEmailTapped()
    func appleSignInTapped(presentationAnchor: UIWindow)
}
