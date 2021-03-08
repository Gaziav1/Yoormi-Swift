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
                    #warning("Это в данным момент не используется, разбирись потом")
                   message = configurateFullErrorMessage(from: data)
                }
                log.debug(providerErrorResponse.message)
                return ProviderError(message: providerErrorResponse.message, status: response.statusCode)
            } catch {
                return ProviderError(message: "Пожалуйста, попытайтесь еще раз", status: 0)
            }
        case .imageMapping, .jsonMapping, .stringMapping, .objectMapping, .encodableMapping:
            log.debug(error.localizedDescription)
            return ProviderError(message: "Не удалось подготовить данные", status: error.response?.statusCode ?? 0)
        case .underlying:
            log.debug(error.localizedDescription)
            return ProviderError(message: error.localizedDescription, status: error.response?.statusCode ?? 0)
        case .requestMapping(let message):
            log.debug(error.localizedDescription)
            return ProviderError(title: "Не удалось сформировать запрос к серверу", message: message, status: error.response?.statusCode ?? 0)
        case .parameterEncoding:
            log.debug(error.localizedDescription)
            return ProviderError(title: "Не удалось сформировать URL для запроса", message: "Пожалуйста, попытайтесь еще раз", status: error.response?.statusCode ?? 0)
        }
    }
    
    private func configurateFullErrorMessage(from fields: [ErrorFields]) -> String {
        var message = ""
        fields.forEach({ field in
            message += field.msg + ", "
        })
        return message
    }
}
