//
//  ProviderError.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

struct ProviderError: Swift.Error, CustomStringConvertible {
    
    var title: String
    var message: String
    var status: Int

    var description: String {
        return "status: \(status) | title: \(title) | message: \(message) "
    }
}


extension ProviderError {
    init(message: String, status: Int = 0) {
        self.title = status == 500 ? "Ошибка на стороне сервера, пожалуйста попытайтесь позднее" : "Что-то пошло не так, пожалуйста повторите попытку"
        self.status = status
        self.message = message
    }
}
