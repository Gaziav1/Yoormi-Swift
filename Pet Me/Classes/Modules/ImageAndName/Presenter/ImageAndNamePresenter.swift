//
//  ImageAndNameImageAndNamePresenter.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

import Foundation

class ImageAndNamePresenter: ImageAndNameModuleInput, ImageAndNameInteractorOutput {
    
    weak var view: ImageAndNameViewInput!
    var interactor: ImageAndNameInteractorInput!
    var router: ImageAndNameRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
}


extension ImageAndNamePresenter: ImageAndNameViewOutput {
    func saveProfile(withImageData data: Data?, name: String) {
        guard let nameData = name.data(using: .utf8) else { return }
        interactor.saveProfile(imageData: data, name: nameData)
    }
}
