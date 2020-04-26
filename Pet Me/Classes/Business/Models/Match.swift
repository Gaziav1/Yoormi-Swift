//
//  Match.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 24.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

struct Match {
    let name: String
    let profileImageURL: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageURL = dictionary["imageURL"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
