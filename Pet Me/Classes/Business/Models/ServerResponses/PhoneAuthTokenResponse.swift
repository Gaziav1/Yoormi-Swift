//
//  PhoneAuthTokenResponse.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 22.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

struct PhoneAuthTokenResponse: Codable {
    let token: String
    let user: User
}
