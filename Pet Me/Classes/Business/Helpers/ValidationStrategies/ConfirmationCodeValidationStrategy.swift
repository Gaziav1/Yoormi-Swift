//
//  ConfirmationCodeValidationStrategy.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 25.01.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation

class ConfirmationCodeValidationStrategy: ValidationStrategy {
    
    private var appliedText = ""
    
    var isValid: Bool {
        return appliedText.count == 6
    }
    
    func validate(text: String) -> String {
        
        if text == "" {
            appliedText.removeLast()
            return appliedText
        }
        
        if appliedText.count == 6 {
            return appliedText
        }
        
        appliedText.append(text)
        return appliedText
    }
}

