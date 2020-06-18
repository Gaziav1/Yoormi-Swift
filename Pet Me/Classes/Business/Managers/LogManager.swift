//
//  LogManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

class LogManager {
    
    static func configurateLogs() {
        let console = ConsoleDestination()
        
        log.addDestination(console)
    }
}
