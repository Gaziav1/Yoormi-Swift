//
//  Animation.swift
//  Yoormi
//
//  Created by 1 on 28.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit


struct Animation {
    let time: Double
    let start: (UIView) -> ()
}


extension Animation {
    
    static func fadeAnimation(time: Double, show: Bool) -> Animation {
        return Animation(time: time) { (view) in
            view.alpha = show ? 1 : 0
        }
    }
}


extension UIView {
    func animate(_ animations: [Animation]) {
        var animations = animations
        guard let animation = animations.first else { return }
        
        
        UIView.animate(withDuration: animation.time, animations: { animation.start(self) }, completion: { [weak self] _ in
            animations.removeFirst()
            self?.animate(animations)
        })
    }
}
