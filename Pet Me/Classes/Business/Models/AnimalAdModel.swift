//
//  AnimalAdModel.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation

struct AnimalAd: Codable {
    
    let address: Coordinates
    let text: String
    let price: Int
    let animal: Animal
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case animal = "animalId"
        case owner = "ownerId"
        
        case text
        case price
        case address
    }
    
}
