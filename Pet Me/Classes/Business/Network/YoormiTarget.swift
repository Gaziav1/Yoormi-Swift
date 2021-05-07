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
    case getAds
    
    //MARK: - AD creation
    case createAd(_ adRequestModel: AnimalAdRequestModel)
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
        case .createAd:
            return "ads/createAd"
        case .getAds:
            return "ads"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .phoneSignUp, .phoneCodeCofirmation, .saveImageAndName, .createAd:
            return .post
        case .animalSubtypes, .getAds:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    
    var task: Task {
        switch self {
        case let .createAd(adRequestModel):
            let mirror = Mirror.init(reflecting: adRequestModel)
            #warning("IMAGES NOT OPTIONAL")
            var dataToUpload = adRequestModel.images?.enumerated().map {
                MultipartFormData(provider: .data($0.element), name: "images", fileName: "\($0.offset).png", mimeType: "image/png")
            }
            
        
            for i in mirror.children {
                guard let key = i.label else { continue }
                if key == "images" || key == "coordinates" {
                    continue
                }
                
                let dataString = String(describing: i.value)
                guard let dataUTF = dataString.data(using: .utf8) else { continue }
                let multipartData = MultipartFormData(provider: .data(dataUTF), name: key)
                dataToUpload?.append(multipartData)
            }
            
            if let coordinates = adRequestModel.coordinates {
                guard let longData = coordinates.long.data(using: .utf8), let latData = coordinates.lat.data(using: .utf8) else { return .uploadMultipart(dataToUpload!) }
                dataToUpload?.append(MultipartFormData(provider: .data(longData), name: "long"))
                dataToUpload?.append(MultipartFormData(provider: .data(latData), name: "lat"))
            }
            
            return .uploadMultipart(dataToUpload!)
        case let .phoneSignUp(phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case let .phoneCodeCofirmation(code, phone):
            return .requestParameters(parameters: ["code": code, "phone": phone], encoding: JSONEncoding.default)
        case let .saveImageAndName(image, name):
            
            var data: [MultipartFormData] = [MultipartFormData(provider: .data(name), name: "name")]
            guard let imageData = image else { return .uploadMultipart(data) }
            data.append(MultipartFormData(provider: .data(imageData), name: "image", fileName: "avatarFile.png", mimeType: "image/png"))
            return .uploadMultipart(data)
        case .animalSubtypes(let animalTypes):
            return .requestParameters(parameters: ["type": animalTypes.requestString], encoding: URLEncoding.queryString)
        case .getAds:
            return .requestPlain
        }
    }
   
    var headers: [String : String]? {
        return nil
    }
    
}
