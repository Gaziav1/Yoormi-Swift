//
//  ImageAndNameImageAndNameViewInput.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

protocol ImageAndNameViewInput: class {

    /**
        @author Gaziav
        Setup initial state of the view
    */

    func setupInitialState()
    func showError(head: String, body: String)
}
