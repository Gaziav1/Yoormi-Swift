//
//  CardsCardsInteractorOutput.swift
//  Yoormi
//
//  Created by Gaziav on 28/04/2021.
//  Copyright © 2021 Gaziav. All rights reserved.
//

import Foundation

protocol CardsInteractorOutput: class {
    func showError(_ providerError: ProviderError)
    func adsFetchDidSuccess(_ animalAd: [AnimalAd])
}
