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
    case phoneSignUp(phone: String)
    case phoneCodeCofirmation(code: String, phone: String)
    case saveImageAndName(image: Data?, name: Data)
    case animalSubtypes(_ type: AnimalTypes)
}

extension YoormiTarget: TargetType {
    var baseURL: URL {
        return Configurations.current.baseURL
    }
    
    var path: String {
        switch self {
        case .phoneSignUp:
            return "auth/phoneauth"
        case .phoneCodeCofirmation:
            return "auth/phoneverify"
        case .saveImageAndName:
            return "auth/createProfile"
        case .animalSubtypes(_):
            return "animalInfo/animalSubtypes"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .phoneSignUp, .phoneCodeCofirmation, .saveImageAndName:
            return .post
        case .animalSubtypes:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .phoneSignUp(phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case let .phoneCodeCofirmation(code, phone):
            return .requestParameters(parameters: ["code": code, "phone": phone], encoding: JSONEncoding.default)
        case let .saveImageAndName(image, name):
            
            var data: [MultipartFormData] = [MultipartFormData(provider: .data(name), name: "name")]
            guard let imageData = image else { return .uploadMultipart(data) }
            data.append(MultipartFormData(provider: .data(imageData), name: "image", fileName: "avatarFile", mimeType: "image/jpeg"))
            return .uploadMultipart(data)
        case .animalSubtypes(let animalTypes):
            return .requestParameters(parameters: ["type": animalTypes.requestString], encoding: URLEncoding.queryString)
        }
    }
   
    var headers: [String : String]? {
        return nil
    }
}
