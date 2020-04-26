//
//  Shadow.swift
//  Pet Me
//
//  Created by Газияв Исхаков on 24.04.2020.
//  Copyright © 2020 Газияв Исхаков. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true, shadowOffset: CGSize, opacity: Float = 0.2, radius: CGFloat = 2 ) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(white: 0, alpha: 0.3).cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
