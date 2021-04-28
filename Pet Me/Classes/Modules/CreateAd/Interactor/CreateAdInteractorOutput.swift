//
//  CreateAdCreateAdInteractorOutput.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation
import CoreLocation

protocol CreateAdInteractorOutput: class {
    
    func fetchSubtypesSuccess(_ subtypes: [AnimalSubtypes])
    func showError(_ error: ProviderError)
    func requestForLocationSucceeded(_ location: String, _ coordinate: CLLocationCoordinate2D)
    func requestForLocationFailed()
    func didSaveUserAd()
}
