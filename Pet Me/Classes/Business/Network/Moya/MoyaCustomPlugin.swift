//
//  MoyaCustomPlugin.swift
//  Yoormi
//
//  Created by 1 on 27.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import Foundation
import Moya

struct MoyaCustomPlugin: PluginType {
    let verbose: Bool

    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            #if DEBUG
            if let body = request.httpBody,
               let str = String(data: body, encoding: .utf8) {
                if verbose {
                    log.debug("request to send: \(str))")
                }
            } else {
                log.debug(request.httpBody)
            }
            #endif
            return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case .success(let body):
            if verbose {
                if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                    log.debug("Response: \n\(json)")
                } else {
                    let response = String(data: body.data, encoding: .utf8)!
                    log.debug(response)
                }
            }
        case .failure( _):
            break
        }
        #endif
    }

}
