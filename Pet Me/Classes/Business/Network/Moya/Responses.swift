//
//  Responses.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let message: String
    let data: [ErrorFields]?
}

struct ErrorFields: Decodable {
    let param: String
    let value: String
    let msg: String
}
