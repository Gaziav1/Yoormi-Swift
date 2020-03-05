//
//  User.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 26.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    let name: String
    let age: Int
    let description: String
    let imageNames: [String]
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 30, weight: .heavy)])
        attributedText.append(NSAttributedString(string: ", \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(description)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
    }
}

