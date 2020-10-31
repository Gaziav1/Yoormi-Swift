//
//  YoormiTarget.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.10.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation
import Moya

enum YoormiTarget {
    
    
    //MARK: - Auth
    case signUp(email: String, password: String)
    case signIn(email: String, password: String)
}

extension YoormiTarget: TargetType {
    var baseURL: URL {
        return Configurations.current.baseURL
    }
    
    var path: String {
        switch self {
        case .signUp(_, _):
            return "auth/signup"
        case .signIn(_, _):
            return "auth/signin"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp(_, _), .signIn(_, _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .signUp(email, password):
            return .requestParameters(parameters: ["email": email, "password": password, "name": "ObiWanKenobi"], encoding: JSONEncoding.default)
        case let .signIn(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
