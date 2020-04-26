//
//  Images.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 22.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit.UIImage

enum Asset {
    enum Icons {
        static let catIcon = #imageLiteral(resourceName: "cat")
        
        static let dogIcon = #imageLiteral(resourceName: "dog")
        
        static let closeIcon = #imageLiteral(resourceName: "close")
        
        static let dismissIcon = #imageLiteral(resourceName: "dismiss_circle")
        
        static let infoIcon = #imageLiteral(resourceName: "info")
        
        static let refreshIcon = #imageLiteral(resourceName: "refresh_circle")
        
        static let profileIcon = #imageLiteral(resourceName: "top_left_profile")
        
        static let messagesIcon = #imageLiteral(resourceName: "top_right_messages")
        
        static let likeIcon = #imageLiteral(resourceName: "like_circle")
    }
    
    enum SystemIcons {
        
        static let arrowUpCircle: UIImage = {
           let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
           let image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: imageConfig)
            return image!
        }()
        
        static let arrowLeft: UIImage = UIImage(systemName: "chevron.left")!
    }
    
    enum Placeholders {
        
        static let doggoPlaceholder1 = #imageLiteral(resourceName: "DoggoTest2")
        
        static let doggoPlaceholder2 = #imageLiteral(resourceName: "DoggoTest")
    }
}
