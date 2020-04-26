//
//  User.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 26.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

struct AppUser {
    var name: String?
    var age: Int?
    var description: String?
    var imageNames: [String]
    var uid: String
    var species: String?
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["fullName"] as? String
        self.uid = dictionary["uid"] as! String
        self.age = dictionary["age"] as? Int
        self.description = dictionary["description"] as? String 
        
        let imageURLs = dictionary["imageURLs"] as? [String]
        self.imageNames = imageURLs!
     }

}

