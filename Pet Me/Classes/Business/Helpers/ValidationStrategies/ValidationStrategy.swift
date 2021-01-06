//
//  ValidationStrategy.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

protocol ValidationStrategy {
    var isValid: Bool { get }
    func validate(text: String) -> String
}


extension ValidationStrategy {
    var isValid: Bool {
        return true
    }
    
    func validate(text: String) -> String {
        return text
    }
}

class DefaultValidationStrategy: ValidationStrategy { }
