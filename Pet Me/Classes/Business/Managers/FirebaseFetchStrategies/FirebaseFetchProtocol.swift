//
//  FirebaseFetchProtocol.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import ObjectMapper

protocol FirebaseSrategiesProtocol {
    func fetchData(completion: @escaping (Result<[Mappable], Error>) -> Void)
    func uploadData(data: Mappable, completion: @escaping (Error?) -> Void)
}
