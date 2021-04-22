//
//  AnimalAdRequestModel.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation
import CoreLocation

struct AnimalAdRequestModel: Encodable {
    var name: String
    var animalType: String
    var age: Int
    var isMale: Bool
    var animalSubType: String
    var images: [Data]
    var coordinates: Coordinates?
    var text: String
    var price: Int
    var isReadyForSale: Bool
}

struct Coordinates: Codable {
    var lat: Double
    var long: Double
    
    init(_ coordinates: CLLocationCoordinate2D) {
        self.lat = coordinates.latitude
        self.long = coordinates.longitude
    }
}
