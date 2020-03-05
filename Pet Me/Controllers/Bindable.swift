//
//  Bindable.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 05.03.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    typealias Observer = ((T?) -> Void)
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }

    var observer: Observer?
    
    func bind(observer: @escaping Observer) {
        self.observer = observer
        observer(value)
    }
}
