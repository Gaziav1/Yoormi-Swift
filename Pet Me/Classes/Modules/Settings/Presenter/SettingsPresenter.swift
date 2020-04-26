//
//  SettingsSettingsPresenter.swift
//  PetMe
//
//  Created by Gaziav on 23/04/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

class SettingsPresenter: SettingsModuleInput, SettingsViewOutput, SettingsInteractorOutput {

    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!

    func viewIsReady() {

    }
}
