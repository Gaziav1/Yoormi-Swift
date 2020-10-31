//
//  User.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 31.10.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var image: String?
}
