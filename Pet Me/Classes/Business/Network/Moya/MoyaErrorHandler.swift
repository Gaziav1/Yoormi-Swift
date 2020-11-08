//
//  MoyaErrorHandler.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 02.11.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Moya

class MoyaErrorHandler {
   
    func map(_ error: Swift.Error) -> ProviderError {
        switch error {
        case let error as MoyaError:
            let providerError = mapMoyaError(error)
            log.verbose(providerError)
            return providerError
        default:
            return ProviderError(title: "Неизвестная ошибка", message: "Пожалуйста, попытайтесь еще раз", status: 0)
        }
    }
    
    private func mapMoyaError(_ error: MoyaError) -> ProviderError {
        switch error {
        case .statusCode(let response):
            do {
                let providerErrorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                var message = ""
                if let data = providerErrorResponse.data {
                   message = configurateFullErrorMessage(from: data)
                }
                
                return ProviderError(message: message, status: response.statusCode)
            } catch {
                return ProviderError(message: "Пожалуйста, попытайтесь еще раз", status: 0)
            }
        case .imageMapping, .jsonMapping, .stringMapping, .objectMapping, .encodableMapping:
            return ProviderError(message: "Не удалось подготовить данные", status: 0)
        case .underlying:
            let internalError = error as NSError
            return ProviderError(message: internalError.localizedDescription, status: internalError.code)
        case .requestMapping(let message):
            return ProviderError(title: "Не удалось сформировать запрос к серверу", message: message, status: 0)
        case .parameterEncoding:
            return ProviderError(title: "Не удалось сформировать URL для запроса", message: "Пожалуйста, попытайтесь еще раз", status: 0)
        }
    }
    
    private func configurateFullErrorMessage(from fields: [ErrorFields]) -> String {
        var message = ""
        fields.forEach({ field in
            message += field.msg + " "
        })
        return message
    }
}
