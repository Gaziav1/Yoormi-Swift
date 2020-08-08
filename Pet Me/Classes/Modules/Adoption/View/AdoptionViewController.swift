//
//  AdoptionAdoptionViewController.swift
//  PetMe
//
//  Created by Gaziav on 08/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class AdoptionViewController: UIViewController, AdoptionViewInput {

    var output: AdoptionViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: AdoptionViewInput
    func setupInitialState() {
    }
}
