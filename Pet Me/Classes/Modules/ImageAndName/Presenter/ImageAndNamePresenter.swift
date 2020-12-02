//
//  ImageAndNameImageAndNamePresenter.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

class ImageAndNamePresenter: ImageAndNameModuleInput, ImageAndNameViewOutput, ImageAndNameInteractorOutput {

    weak var view: ImageAndNameViewInput!
    var interactor: ImageAndNameInteractorInput!
    var router: ImageAndNameRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
}
