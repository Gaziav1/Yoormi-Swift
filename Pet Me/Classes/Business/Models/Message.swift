//
//  Message.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 24.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Firebase

struct Message {
    let text: String
    let from: String
    let to: String
    let time: Timestamp
    let isMessageFromCurrentUser: Bool
    
    init(dict: [String: Any]) {
        self.text = dict["text"] as? String ?? ""
        self.from = dict["from"] as? String ?? ""
        self.time = dict["time"] as? Timestamp ?? Timestamp(date: Date())
        self.to = dict["to"] as? String ?? ""
        
        self.isMessageFromCurrentUser = Auth.auth().currentUser?.uid == self.from
        
    }
}
