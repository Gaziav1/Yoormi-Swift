//
//  MessagesMessagesViewController.swift
//  PetMe
//
//  Created by Gaziav on 23/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import UIKit

class MessagesViewController: UICollectionViewController, MessagesViewInput {

    var output: MessagesViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: MessagesViewInput
    func setupInitialState() {
    }
}
