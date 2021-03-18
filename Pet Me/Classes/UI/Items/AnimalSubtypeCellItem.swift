//
//  AnimalSubtypeCellItem.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 13.03.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation


struct AnimalSubtypeCellItem {
    let name: String
    
    init(_ animalSubtype: AnimalSubtypes) {
        self.name = animalSubtype.name
    }
}
