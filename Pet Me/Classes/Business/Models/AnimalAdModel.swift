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
}
