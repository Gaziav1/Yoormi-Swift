//
//  FirebaseFetchProtocol.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 30.06.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

protocol FirebaseSrategiesProtocol {
    func fetchData(completion: @escaping (Result<[Codable], Error>) -> Void)
    func uploadData(data: [String: Any], completion: @escaping (Error?) -> Void)
}
