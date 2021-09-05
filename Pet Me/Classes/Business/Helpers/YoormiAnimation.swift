//
//  Animation.swift
//  Yoormi
//
//  Created by 1 on 28.04.2021.
//  Copyright © 2021 Газияв Исхаков. All rights reserved.
//

import UIKit


struct YoormiAnimation {
    let time: Double
    let start: (UIView) -> ()
}


extension YoormiAnimation {
    
    static func fadeAnimation(time: Double, show: Bool) -> YoormiAnimation {
        return YoormiAnimation(time: time) { $0.alpha = show ? 1 : 0 }
    }
    
    static func initialTransformAnimation(time: Double) -> YoormiAnimation {
        return YoormiAnimation(time: time) { $0.transform = .identity }
    }
}


extension UIView {
    func animate(_ animations: [YoormiAnimation]) {
        var animations = animations
        guard let animation = animations.first else { return }
        
        UIView.animate(withDuration: animation.time, animations: { animation.start(self) }, completion: { [weak self] _ in
            animations.removeFirst()
            self?.animate(animations)
        })
    }
}


