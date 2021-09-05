//
//  LocalizationKeys.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 21.02.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation


enum LocalizationKeys: String {
    
    case animalSubtypeLabel = "animal-subtype-label"
    case animalTypeLabel = "animal-type-label"
    case addProfilePhotoLabel = "add-profile-photo"
    case userNameTextField = "user-name-text-field"
    case continueButtonTitle = "done-button-title"
    case requestCodePhoneButtonTitle = "request-code-phone-button-title"
    case confirmCodeButtonTitle = "confirm-code-button-title"
    case addPetPhotos = "add-pet-photos"
    case addPetDescription = "add-pet-description"
    case yourAddress = "your_address"
    case addressNote = "address_note"
    case loadingState = "loading-state"
    case phone
    case male
    case female
    case name
    case next
    case emptyString
    
    
    var localized: String {
        return self.rawValue.localized()
    }
}
