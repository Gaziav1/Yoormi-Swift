//
//  User.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 26.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import ObjectMapper

struct AppUser: Mappable {
    
    var name: String?
    var imageURL: String?
    var uid: String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        imageURL <- map["imageURL"]
        uid <- map["uid"]
    }
}

