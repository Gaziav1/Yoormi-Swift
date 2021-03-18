//
//  CreateAdCreateAdInteractorOutput.swift
//  PetMe
//
//  Created by Gaziav on 11/08/2020.
//  Copyright © 2020 Gaziav Ishakov. All rights reserved.
//

import Foundation

protocol CreateAdInteractorOutput: class {
    
    func fetchSubtypesSuccess(_ subtypes: [AnimalSubtypes])
    func showError(_ error: ProviderError)
}
