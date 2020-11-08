//
//  Configurations.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.10.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

enum Configurations {
    case debug, `internal`, release
    
    static var current: Configurations {
        #if DEBUG
            return .debug
        #elseif INTERNAL
            return .internal
        #elseif RELEASE
            return .release
        #endif
        }
    
    var baseURL: URL {
        switch self {
        case .release:
            guard let url = URL(string: "http://localhost:3000") else { fatalError("Cannot access release baseURL") }
            return url
        case let _:
            #warning("Change later")
            guard let url = URL(string: "http://localhost:3000") else { fatalError("Cannot access debug baseURL") }
            return url
        }
    }
        
}
