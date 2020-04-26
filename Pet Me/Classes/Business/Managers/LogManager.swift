//
//  LogManager.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 23.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import XCGLogger

let log = LogManager.configurateLogs()

class LogManager {
    
    static func configurateLogs() -> XCGLogger {
        let log = XCGLogger(identifier: "XCGLogger", includeDefaultDestinations: false)
        
        let systemLogDestination = ConsoleDestination(owner: log, identifier: "XCGLogger.console")
    
        systemLogDestination.outputLevel = .debug
        systemLogDestination.showLogIdentifier = false
        systemLogDestination.showFunctionName = true
        systemLogDestination.showThreadName = false
        systemLogDestination.showLevel = true
        systemLogDestination.showFileName = true
        systemLogDestination.showLineNumber = true
        systemLogDestination.showDate = true
        log.add(destination: systemLogDestination)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:ss.SSS"
        log.dateFormatter = dateFormatter
        
        return log
    }
}
