//
//  ImageAndNameImageAndNamePresenter.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

import Foundation

class ImageAndNamePresenter: ImageAndNameModuleInput {
    
    weak var view: ImageAndNameViewInput!
    var interactor: ImageAndNameInteractorInput!
    var router: ImageAndNameRouterInput!

}


//MARK: - ImageAndNameInteractorOutput
extension ImageAndNamePresenter: ImageAndNameInteractorOutput {
    func userProfileSaved() {
        router.performTransitionToAdoption()
    }
    
    func showError(_ error: ProviderError) {
        view.showError(head: error.title, body: error.message)
    }
}

//MARK: - ImageAndNameViewOutput
extension ImageAndNamePresenter: ImageAndNameViewOutput {
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func saveProfile(withImageData data: Data?, name: String) {
        guard let nameData = name.data(using: .utf8) else { return }
        interactor.saveProfile(imageData: data, name: nameData)
    }
}
