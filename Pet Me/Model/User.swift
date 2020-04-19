//
//  User.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 26.02.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
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
    
    func toCardViewModel() -> CardViewModel {
        
        let attributedText = NSMutableAttributedString(string: name ?? "Мне еще не дали имя", attributes: [.font: UIFont.systemFont(ofSize: 26, weight: .heavy)])
        attributedText.append(NSAttributedString(string: ", \(age ?? 0)", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]))
        attributedText.append(NSAttributedString(string: "\n\(description ?? "Я очень скромный и стесняюсь рассказывать о себе")", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular)]))
        
        
        return CardViewModel(uid: uid, imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
    }
}

