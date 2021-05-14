//
//  CardViewItem.swift
//  Yoormi
//
//  Created by 1 on 14.05.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation


struct CardViewItem {

    let text: String
    let animalName: String
    let animalType: AnimalTypes
    let animalAge: Int
    let isMale: Bool
    let animalSubtype: String
    let imageURLs: [String]
    let ownerName: String
    let ownerAvatarURL: String
    
    
    init(adModel: AnimalAd) {
        self.text = adModel.text
        self.animalName = adModel.animal.name
        self.animalType = AnimalTypes.init(rawValue: adModel.animal.animalType) ?? .dog
        self.animalAge = adModel.animal.age
        self.isMale = adModel.animal.isMale
        self.animalSubtype = adModel.animal.animalSubtype
        self.imageURLs = adModel.animal.imageURLs
        self.ownerName = adModel.owner.name ?? "Unknown"
        self.ownerAvatarURL = adModel.owner.image ?? ""
    }
}
