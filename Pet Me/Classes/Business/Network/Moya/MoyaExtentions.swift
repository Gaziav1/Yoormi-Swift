//
//  MoyaExtentions.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 31.10.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import RxSwift
import Moya


extension MoyaProvider {
    
    var errorHandler: MoyaErrorHandler {
        return MoyaErrorHandler()
    }
    
    func requestModel<Model: Codable>(_ token: Target, _: Model.Type) -> Observable<Model> {
        return rx
            .request(token)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map(Model.self)
            .catchError({ [unowned self] error in
                Observable.error(self.errorHandler.map(error))
            })

    }
    
    func requestArray<Model: Codable>(_ token: Target, _: Model.Type) -> Observable<[Model]> {
        return rx
            .request(token)
            .filterSuccessfulStatusCodes()
            .asObservable()
            .map([Model].self)
            .catchError({ [unowned self] error in
                Observable.error(self.errorHandler.map(error))
            })
    }
}
