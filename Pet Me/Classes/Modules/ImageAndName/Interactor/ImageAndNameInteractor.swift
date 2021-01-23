//
//  ImageAndNameImageAndNameInteractor.swift
//  Yoormi
//
//  Created by Gaziav on 02/12/2020.
//  Copyright © 2020 Gaziav. All rights reserved.
//

import Moya
import Foundation
import RxSwift

class ImageAndNameInteractor {
    private let disposeBag = DisposeBag()
    weak var output: ImageAndNameInteractorOutput!
    var provider: MoyaProvider<YoormiTarget>!
}


extension ImageAndNameInteractor: ImageAndNameInteractorInput {
    func saveProfile(imageData: Data?, name: Data) {
    
        provider
            .requestModel(.saveImageAndName(image: imageData, name: name), User.self)
            .subscribe({ [weak self] response in
                switch response {
                case .next:
                    print("success")
                case .error(let error as ProviderError):
                    print(error.localizedDescription)
                default: ()
                }
            }).disposed(by: disposeBag)
    }
}
