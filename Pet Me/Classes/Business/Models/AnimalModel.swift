//
//  AnimalModel.swift
//  Yoormi
//
//  Created by 1 on 30.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation

struct Animal: Codable {
    let name: String
    let animalType: String
    let age: Int
    let isMale: Bool
    let animalSubtype: String
    let imageURLs: [String]
}
