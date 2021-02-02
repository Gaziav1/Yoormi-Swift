//
//  PhoneValidation.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

class PhoneValidation: ValidationStrategy {
    
    private let mask = "+X (XXX) XXX-XX-X"
    private var text = ""
    
    var isValid: Bool {
        if text.starts(with: "+7") && text.count == mask.count {
            return true
        } else {
            return false
        }
    }
    
    func validate(text: String) -> String {
        return format(phone: text)
    }
    
    private func format(phone: String) -> String {
    
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch) 
            }
        }
        self.text = result
        return result
    }
}

