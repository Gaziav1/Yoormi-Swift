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
    
    func requestModel<Model: Codable>(_ token: Target, _: Model.Type) -> Observable<Model> {
        return rx
            .request(token)
            .asObservable()
            .map(Model.self)
            .catchError({ error in
                Observable.error(error)
            })
    }
    
    
}
